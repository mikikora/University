(* Zadanie 1 *)

type 'a btree = Leaf | Node of 'a btree * 'a * 'a btree;;
let balance t = 
    let rec aux t = 
        match t with
            | Leaf -> (0, true)
            | Node(t1,  _,  t2) -> let t1_num, t1_b = aux t1 and t2_num, t2_b = aux t2 in
                if t1_b && t2_b && abs (t1_num - t2_num) <= 1
                    then ( t1_num + t2_num + 1 , true) 
                    else (0, false)
    in let num, res = aux t in res;;

let halve xs =
    let rec aux acc xs counter = 
        match counter with
        | [] | [_] -> (List.rev acc), xs
        | hd::tail -> aux (List.hd xs::acc) (List.tl xs) (List.tl tail)   
    in aux [] xs xs;;

let build_tree xs = 
    let rec aux xs = 
        match xs with
            | [] -> Leaf
            | [x] -> Node(Leaf, x, Leaf)
            | hd::tl -> let x1, x2 = halve tl in 
                let t1 = aux x1 and t2 = aux x2 in
                    Node(t1, hd, t2)
    in aux xs;;
    

(* Zadanie 2 *)
type 'a place = 'a list * 'a list;;
let findNth xs n: 'a place = 
    let rec aux x1 x2 acc = 
        if acc = n 
        then (x1, x2)
        else aux ((List.hd x2)::x1) (List.tl x2) (acc+1)
    in aux [] xs 0;;

let collapse (p: 'a place) =
    List.rev_append (fst p) (snd p);;

let add n (p: 'a place): 'a place = 
    (fst p), n::(snd p);;

let del (p: 'a place): 'a place =
    fst p, (List.tl (snd p));;

let next (p: 'a place): 'a place = 
    (List.hd (snd p))::(fst p), List.tl (snd p);;

let prev (p: 'a place): 'a place = 
    List.tl (fst p), (List.hd (fst p))::(snd p);;


(* Zadanie 7 *)
(* punkty a, b, d *)
imp_i (Var "p") (by_assumption (Var "p"));;
imp_i (Var "p") (imp_i (Var "q") (by_assumption (Var "p")));;
imp_i False (bot_e (Var "p") (by_assumption False));;

(* punkt c *)
let t1 = imp_e (by_assumption (Imp(Var "p", Imp(Var "q", Var "r")))) (by_assumption (Var "p"));;
let t2 = imp_e (by_assumption (Imp (Var "p", Var "q"))) (by_assumption (Var "p"));;
let t3 = imp_e t1 t2;;
 imp_i (Imp (Var "p", (Imp (Var "q", Var "r")))) (imp_i (Imp (Var "p", Var "q")) (imp_i (Var "p") t3));;

