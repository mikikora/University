open Logic;;
open Proof;;

#install_printer Logic.pp_print_theorem;;

#install_printer Logic.pp_print_formula;;

#install_printer Proof.pp_print_goal;;

#install_printer Proof.pp_print_proof;;

let p = Var("p")
let q = Var("q")
let r = Var("r")

let f1 = Imp(Imp(p,Imp(q,r)),Imp(Imp(p,q), Imp(p,r)))

let f2 = Imp(Imp(Imp(Imp(p, False),p),p), Imp(Imp(Imp(p, False),False),p))

let f3 = Imp(Imp(Imp(Imp(p, False),False),p), Imp(Imp(Imp(p, False),p),p))

(*proof [] f1 |> focus 0 |> intro "H1" |> intro "H2" |> intro "H3" |> apply_assm "H1" |> focus 0 |> apply_assm "H3" |> focus 0 |> apply_assm "H2" |> focus 0 |> apply_assm "H3" |> qed;;*)
(* proof [] f2 |> focus 0 |> intro "H1" |> intro "H2" |> apply_assm "H1" |> focus 0 |> intro "H3" |> apply_assm "H2" |> focus 0 |> apply_assm "H3" |> qed;; *)
(* proof [] f3 |> focus 0 |> intro "H1" |> intro "H2" |> apply_assm "H1"|> focus 0 |> intro "H3" |> apply_assm "H3" |> focus 0 |> apply_assm "H2" |> focus 0 |> apply_assm "H3" |> qed;; *)
