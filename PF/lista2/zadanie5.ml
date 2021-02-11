(* Zadanie 5 *)

let rec suff lst = 
    match lst with
        | [] -> [[]]
        | hd::tl -> [lst] @ suff tl;;

let rec pref lst = 
    let xs = List.rev lst in
    let res = suff xs in
    List.map List.rev res;;
