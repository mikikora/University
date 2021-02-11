(* Zadanie 1 *)

let rec sublists lst = 
    let rec append left right elem = 
        match left with
            | [] -> right
            | hd::tl -> append tl ((elem::hd)::right) elem
    in
    match lst with
        | [] -> [[]]
        | hd::tl -> let slst = sublists tl in
            append slst slst hd;;

(* Zadanie 2 *)
let cycle lst n = 
    let rec iter head tail = 
        if n = List.length tail
        then tail @ head
        else iter (head @ [List.hd tail]) (List.tl tail)
        in
    iter [] lst;;

(* Zadanie 3 *)
let rec merge f left right = 
    match (left, right) with
        | ([], _) -> right
        | (_, []) -> left
        | (hdl::tll, hdr::tlr) when f hdl hdr -> hdl::(merge f tll right)
        | (hdl::tll, hdr::tlr) -> hdr::(merge f left tlr);;

let merge_iter f left right = 
    let rec iter left right res = 
        match (left, right) with
            | ([], []) -> res
            | ([], _) -> right @ res
            | (_, []) -> left @ res
            | (hdl::tll, hdr::tlr) when f hdl hdr -> iter tll right (hdl::res)
            | (hdl::tll, hdr::tlr) -> iter left tlr (hdr::res)
        in
    List.rev (iter left right []);;
    
let halve lst = 
    let rec pom left lst count = 
        match count with
            | [] | [_] -> (List.rev left), lst
            | hd::tl -> pom ((List.hd lst)::left) (List.tl lst) (List.tl tl)
        in
    pom [] lst lst;;
    

let rec mergesort lst = 
    match lst with
        | [] | [_] -> lst
        | _ -> let left, right = halve lst in
            let lsorted = mergesort left and rsorted = mergesort right in
                merge (<=) lsorted rsorted;;


let merge_diff f left right = 
    let rec iter left right res = 
        match (left, right) with
            | ([], []) -> res
            | ([], _) -> res @ right
            | (_, []) -> res @ left
            | (hdl::tll, hdr::tlr) when f hdl hdr -> iter tll right (res @ [hdl]) 
            | (hdl::tll, hdr::tlr) -> iter left tlr (res @ [hdr])
        in
    iter left right [];;

let rec mergesort_diff lst = 
    match lst with
        | [] | [_] -> lst
        | _ -> let left, right = halve lst in
            let lsorted = mergesort left and rsorted = mergesort right in
                merge_diff (<=) lsorted rsorted;;


(* Zadanie 4 *)

let rec perm lst = 
    let rec insert x prev acc xs = 
        match xs with
            | [] -> (prev @ [x])::acc
            | hd::tl -> insert x (prev @ [hd]) ((prev @ [x] @ xs)::acc) tl 
    in
    match lst with
        | [] -> [[]]
        | [x] -> [[x]]
        | hd::tl -> let perms = perm tl in 
            List.fold_left (fun x y -> x @ y) [] (List.map (insert hd [] []) perms);;

(* Zadanie 5 *)

let rec suff lst = 
    match lst with
        | [] -> [[]]
        | hd::tl -> [lst] @ suff tl;;

let rec pref lst = 
    let xs = List.rev lst in
    let res = suff xs in
    List.map List.rev res;;

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
