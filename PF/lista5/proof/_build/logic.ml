type term = Var of string | Func of string * term list 
type atom = Rel of string * term list
type formula = Single of atom | Imp of formula * formula | False | ForAll of string * formula

let rec string_of_term t = 
    match t with
        | Var(x) -> x
        | Func(f, ts) -> f ^ "( " ^ (List.fold_right (fun x y -> x ^ " " ^ y) (List.map (fun x -> (string_of_term x) ) ts) "") ^ ")"

let rec string_of_atom a = 
    match a with
        | Rel(p, ts) -> p ^ "( " ^ ( List.fold_right (fun x y -> x ^ " " ^ y) (List.map (fun x -> (string_of_term x) ) ts) "") ^ ")"

let rec string_of_formula f =
    match f with
        | False -> "⊥"
        | Single(x) -> string_of_atom x
        | ForAll(x, f) -> "∀" ^ x ^ "." ^ (string_of_formula f)
        | Imp(a, b) -> match a, b with
            | Imp(_,_), Imp(_,_)-> "(" ^ (string_of_formula a) ^ ") -> " ^ (string_of_formula b) 
            | Imp(_,_), _ -> "(" ^ (string_of_formula a) ^ ") -> " ^ (string_of_formula b)
            | _, Imp(_,_)-> (string_of_formula a) ^ " -> " ^ (string_of_formula b) 
            | _,_ -> (string_of_formula a) ^ " -> " ^ (string_of_formula b);;

let pp_print_formula fmtr f =
  Format.pp_print_string fmtr (string_of_formula f)

let equal_formula f1 f2 =
    let rec equal_checker_t ts1 x1 ts2 x2 =
        let term_checker t1 t2 = 
            match t1, t2 with
                | Var(y1), Var(y2) -> if y1 = x1 then [y2 = x2] else [y1 = y2]
                | Func(name1, ts1), Func(name2, ts2) -> if name1 = name2 then equal_checker_t ts1 x1 ts2 x2 else [false]
                | _, _ -> [false]
        in
        let rec aux xs ys acc =
            match xs, ys with
                | [], [] -> acc
                | hd1::tl1, hd2::tl2 -> aux tl1 tl2 ((term_checker hd1 hd2) @ acc)
                | _, _ -> [false]
        in
        if (List.length ts1) = (List.length ts2) then aux ts1 ts2 [] else [false]
    in
    let equal_checker_a a1 x1 a2 x2 =
        match a1, a2 with
            | Rel(name1, ts1), Rel(name2, ts2) -> if name1 = name2
                then List.fold_right (&&) (equal_checker_t ts1 x1 ts2 x2) true else false
    in
    let rec equal_checker_f f1 x1 f2 x2 =
        match f1, f2 with
            | Single(a1), Single(a2) -> equal_checker_a a1 x1 a2 x2
            | Imp(f11, f12), Imp(f21, f22) ->
                let l = equal_checker_f f11 x1 f21 x2 and r = equal_checker_f f12 x1 f22 x2 in l && r
            | False, False -> true
            | ForAll(y1, g1), ForAll(y2, g2) -> 
                let aux = equal_checker_f g1 y1 g2 y2 in
                    if aux then equal_checker_f g1 x1 g2 x2 else false
            | _, _ -> false
    in
    match f1, f2 with
        | ForAll(x1, f1), ForAll(x2, f2) -> equal_checker_f f1 x1 f2 x2
        | _, _ -> false

type theorem = Ax of formula list * formula
    | ImpI of theorem * (formula list * formula)
    | ImpE of theorem * theorem * (formula list * formula)
    | BotE of theorem * (formula list  * formula)

let assumptions thm =
     match thm with
        | Ax(xs, _)
        | ImpI(_, (xs, _))
        | ImpE(_, _, (xs, _))
        | BotE(_, (xs, _)) -> xs

let consequence thm =
    match thm with
        | Ax(_, x)
        | ImpI(_, (_, x))
        | ImpE(_, _, (_, x))
        | BotE(_, (_, x)) -> x

let pp_print_theorem fmtr thm =
  let open Format in
  pp_open_hvbox fmtr 2;
  begin match assumptions thm with
  | [] -> ()
  | f :: fs ->
    pp_print_formula fmtr f;
    fs |> List.iter (fun f ->
      pp_print_string fmtr ",";
      pp_print_space fmtr ();
      pp_print_formula fmtr f);
    pp_print_space fmtr ()
  end;
  pp_open_hbox fmtr ();
  pp_print_string fmtr "⊢";
  pp_print_space fmtr ();
  pp_print_formula fmtr (consequence thm);
  pp_close_box fmtr ();
  pp_close_box fmtr ()

let by_assumption f =
    Ax([f], f);;

let imp_i f thm =
    ImpI(thm, (List.filter (function x -> not (equal_formula x f)) (assumptions thm) , Imp(f, (consequence thm))))  

let imp_e th1 th2 =
    match (consequence th1) with
        | Imp(x, y) -> if equal_formula x (consequence th2)
            then ImpE(th1, th2, ((assumptions th1) @ (assumptions th2), y))
            else failwith("imp_e got wring arguments")
        | _ -> failwith("imp_e got wrong arguments");;

let bot_e f thm =
    if consequence thm = False
        then BotE( thm, (assumptions thm, f))
        else failwith("bot_e got wrong arguments");;
