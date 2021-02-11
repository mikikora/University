(* Zadanie 6 *)

type 'a clist = { clist : 'z. ('a -> 'z -> 'z) -> 'z -> 'z };;

let cnil = { clist = fun f z -> z };;
let ccons a ys = { clist = fun f z -> f a (ys.clist f z) };;
let map fn xs = { clist = fun f z -> xs.clist (fun a -> f (fn a)) z };;
let append xs ys = { clist = fun f z -> xs.clist f (ys.clist f z) };;
let clist_to_list xs = xs.clist (fun a z -> a::z) [];;
let rec clist_of_list xs = 
    match xs with
        | [] -> cnil
        | hd::tl -> ccons hd (clist_of_list tl);;

let prod xs ys = { clist = fun f z -> xs.clist (fun a -> ys.clist (fun b -> f (a,b))) z };;
