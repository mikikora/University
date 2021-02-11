type formula = Var of string | False | Imp of formula * formula

let rec string_of_formula f =
  match f with
    False -> "⊥"
    |Var s -> s
    |Imp (fl,fr) -> String.concat "" ["(";string_of_formula fl;") → ";string_of_formula fr];;

let pp_print_formula fmtr f =
  Format.pp_print_string fmtr (string_of_formula f)

type osad = formula list * formula

type theorem = 
  Ax of osad
  |ImpI of theorem * osad
  |ImpE of theorem * theorem * osad
  |FalE of theorem * osad


let assumptions thm =
  match thm with
    Ax (asm,_) -> asm
    |ImpI (_,(asm,_)) -> asm
    |ImpE (_,_,(asm,_)) -> asm
    |FalE (_,(asm,_)) -> asm

let consequence thm =
  (* TODO: zaimplementuj *)
  failwith "not implemented"

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
  (* TODO: zaimplementuj *)
  failwith "not implemented"

let imp_i f thm =
  (* TODO: zaimplementuj *)
  failwith "not implemented"

let imp_e th1 th2 =
  (* TODO: zaimplementuj *)
  failwith "not implemented"

let bot_e f thm =
  (* TODO: zaimplementuj *)
  failwith "not implemented"
