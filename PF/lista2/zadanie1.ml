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
