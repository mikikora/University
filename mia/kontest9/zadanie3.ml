module MapExps = Map.Make(Int64)

let id = function x -> x;;
let n = Scanf.scanf "%d " id;;
let x = Scanf.scanf "%Ld\n" id;;

let a, exp = 
    let rec iter acc sum i =
        if i >= n then acc, sum
        else let temp = Scanf.scanf "%Ld " id in
        (Array.set acc i temp; 
        iter acc (Int64.add temp sum) (i + 1)) in
    iter (Array.make n 0L) 0L 0;;

let exps = Array.fold_left (fun acc x -> 
    let x = Int64.sub exp x in
    let value = try MapExps.find x acc 
        with Not_found -> 0L
    in
    MapExps.add x (Int64.add value 1L) acc) MapExps.empty a;;

let update key f map =
    let value = try Some (MapExps.find key map) with Not_found -> None in
    match f value with
        | Some x -> MapExps.add key x map
        | None -> MapExps.remove key map

let exps = MapExps.fold (fun key value exps -> 
    if value >= x
    then update (Int64.succ key) 
        (function | None -> Some (Int64.div value x)
                | Some z -> Some (Int64.add z (Int64.div value x))) 
                    (update key 
                        (function | None -> failwith "what?" | Some z -> Some (Int64.rem z x)) exps)
    else exps) exps exps

let gcd = let value, _ = MapExps.find_first 
    (function key -> let value = MapExps.find key exps in value > 0L) exps in
    let rec pow x n =
        if n = 0L then 1L else
        match Int64.rem n 2L with
            | 0L -> let a = pow x (Int64.div n 2L) in Int64.rem (Int64.mul a a) 1000000007L
            | 1L -> Int64.rem (Int64.mul x (pow x (Int64.sub n 1L))) 1000000007L
            | _ -> failwith "what?"
    in
    pow x value;;

Printf.printf "%Ld" gcd;;

