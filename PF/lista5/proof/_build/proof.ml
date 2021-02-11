open Logic

type context = (string * formula) list
type goalDesc = context * formula

type proof = Empty of goalDesc | Node1 of proof * (theorem -> theorem) 
            | Node2 of proof * proof * (theorem -> theorem -> theorem)
            | Leaf of theorem


type path = Top
            | Left of path * proof * (theorem -> theorem -> theorem)
            | Right of path * proof * (theorem -> theorem -> theorem)
            | Mid of path * (theorem -> theorem)

type goal = Goal of proof * path;;

let rec qed pf =
    match pf with
        | Leaf(x) -> x
        | Node1(pf, f) -> let res_pf = qed pf in f res_pf
        | Node2(p1, p2, f) -> let r1 = qed p1 and r2 = qed p2 in f r1 r2
        | Empty(_) -> failwith("Cannot build theorem from unfinished proof") 

let rec numGoals pf =
    match pf with
        | Empty(_) -> 1
        | Leaf(_) -> 0
        | Node1(pf, _) -> numGoals pf
        | Node2(p1, p2, _) -> let r1=numGoals p1 and r2=numGoals p2 in r1+r2


let rec goals pf =
    match pf with
        | Empty(x) -> [x]
        | Leaf(_) -> []
        | Node1(pf, _) -> goals pf
        | Node2(p1, p2, _) -> let r1 = goals p1 and r2 = goals p2 in List.append r1 r2

let proof g f =
    Empty(g,f)

let goal gl =
    match gl with | Goal(pf, path) ->
    match pf with
        | Empty(x) -> x
        | _ -> failwith("This is not an active goal")

let rec unfocus gl =
    match gl with
        | Goal(pf, path) ->
            match path with 
                | Top -> pf
                | Left(father, right, f) -> unfocus (Goal(Node2(pf, right, f), father))
                | Right(father, left, f) -> unfocus (Goal(Node2(left, pf, f), father))
                | Mid(father, f) -> unfocus (Goal(Node1(pf, f), father))

exception EmptyFound of string
exception LeafFound of string



let go_up pf path = 
    match path with 
        | Top -> failwith("going up when on top")
        | Left(father, right, f) -> Goal(Node2(pf, right, f), father)
        | Right(father, left, f) -> Goal(Node2(left,pf, f), father)
        | Mid(father, f) -> Goal(Node1(pf, f), father)

let go_down pf path r = 
    match pf with
        | Empty(_) -> raise(EmptyFound "going down with empty")
        | Node1(p, f) -> Goal(p, Mid(path, f))
        | Node2(p1, p2, f) -> if r then Goal(p2, Right(path, p1, f)) else Goal(p1, Left(path, p2, f))
        | Leaf(_) -> raise(LeafFound "going down with leaf")

let rec next gl =
    let rec going_down pf path = 
        try let Goal(pf, path) = go_down pf path false in going_down pf path
        with 
            | EmptyFound(_) -> Goal(pf, path)
            | LeafFound(_) -> next (Goal(pf,path))
    in
    match gl with
        | Goal(pf, path) -> match path with
            | Top -> going_down pf path 
            | Left(_, _, _) -> let Goal(pf, path) = go_up pf path in let Goal(pf, path) = go_down pf path true in going_down pf path
            | Right(_, _, _) -> next (go_up pf path)
            | Mid(_, _) -> next (go_up pf path) 


let focus n pf =
    let len = (List.length (goals pf) - 1) in
    let g0 = next ( Goal (pf, Top) ) in
    let rec aux g acc =
        if acc > len then failwith("too big number") else
            if acc = n then g else aux (next g) (acc + 1)
    in aux g0 0


(*ta funkcja nie jest nigdy przydatna *)
let rec prev gl =
    let rec going_down pf path =
        try let Goal(pf, path) = go_down pf path true in going_down pf path
        with
            | EmptyFound(_) -> Goal(pf,path)
            | LeafFound(_) -> prev (Goal(pf,path))
    in
    match gl with
        | Goal(pf, path) -> match path with
            | Top -> going_down pf path
            | Left(_,_,_) -> prev (go_up pf path)
            | Right(_,_,_) -> let Goal(pf, path) = go_up pf path in let Goal(pf, path) = go_down pf path false in going_down pf path
            | Mid(_) -> prev (go_up pf path)

let intro name gl =
    match gl with
        | Goal(pf, path) -> match pf with 
            | Node1(_, _)
            | Node2(_, _, _) 
            | Leaf(_) -> failwith("this is not an empty goal")
            | Empty(ctx, form) -> match form with
                | Imp(l, r) -> Goal(Empty((name, l)::ctx, r), Mid(path, imp_i l))
                | _ -> failwith("this is not imp")

let rec apply f gl =
    let Goal(pf, path) = gl in
    match pf with
        | Node1(_, _) 
        | Node2(_, _, _) 
        | Leaf(_) -> failwith("wrong goal")
        | Empty(ctx, form) -> if f = form then gl else
    match f with
        | False -> if form = False then gl else Goal(Empty(ctx, False), Mid(path, bot_e form))
        | Imp(l, r) -> if l = form then
            Goal(Empty(ctx, f), Left(path, Empty(ctx, l), imp_e)) else 
            if r = False then 
            if form = False then let Goal(pf_father, father_path) = apply r gl in Goal(Empty(ctx, f), Left(father_path, Empty(ctx, l), imp_e))
            else apply f (Goal(Empty(ctx, False), Mid(path, bot_e form)))
            else
            let Goal(pf_father, father_path) = apply r gl in
            Goal(Empty(ctx, f), Left(father_path, Empty(ctx, l), imp_e))
        | _ -> failwith("this is not imp")

let apply_thm thm gl =
    let Goal(_, path) = gl in
    let Goal(_, new_path) = apply (Logic.consequence thm) gl in
    unfocus (Goal(Leaf(thm), new_path))

let apply_assm name gl =
    let Goal(pf, path) = gl in 
    match pf with
        | Node1(_, _)
        | Node2(_, _, _)
        | Leaf(_) -> failwith("wrong goal")
        | Empty(ctx, form) ->
            let f = List.assoc name ctx in 
                let Goal(_, new_path) = apply f gl in unfocus (Goal(Leaf(Logic.by_assumption f), new_path))


let pp_print_proof fmtr pf =
  let ngoals = numGoals pf
  and goals = goals pf
  in if ngoals = 0
  then Format.pp_print_string fmtr "No more subgoals"
  else begin
      Format.pp_open_vbox fmtr (-100);
      Format.pp_open_hbox fmtr ();
      Format.pp_print_string fmtr "There are";
      Format.pp_print_space fmtr ();
      Format.pp_print_int fmtr ngoals;
      Format.pp_print_space fmtr ();
      Format.pp_print_string fmtr "subgoals:";
      Format.pp_close_box fmtr ();
      Format.pp_print_cut fmtr ();
      goals |> List.iteri (fun n (_, f) ->
       Format.pp_print_cut fmtr ();
       Format.pp_open_hbox fmtr ();
       Format.pp_print_int fmtr (n + 1);
       Format.pp_print_string fmtr ":";
       Format.pp_print_space fmtr ();
       pp_print_formula fmtr f;
       Format.pp_close_box fmtr ());
      Format.pp_close_box fmtr ()
    end

let pp_print_goal fmtr gl =
  let (g, f) = goal gl
  in
  Format.pp_open_vbox fmtr (-100);
  g |> List.iter (fun (name, f) ->
      Format.pp_print_cut fmtr ();
      Format.pp_open_hbox fmtr ();
      Format.pp_print_string fmtr name;
      Format.pp_print_string fmtr ":";
      Format.pp_print_space fmtr ();
      pp_print_formula fmtr f;
      Format.pp_close_box fmtr ());
  Format.pp_print_cut fmtr ();
  Format.pp_print_string fmtr (String.make 40 '=');
  Format.pp_print_cut fmtr ();
  pp_print_formula fmtr f;
  Format.pp_close_box fmtr ()
