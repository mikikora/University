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


