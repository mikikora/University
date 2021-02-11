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
