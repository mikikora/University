include Hashtbl

let fib_f fib n =
    if n <= 1 then n
    else fib (n-1) + fib (n-2)

let rec fix_with_limit n f x = 
    if n <= 0 
        then failwith "Maximum recursion depth exceeded" 
        else f (fix_with_limit (n-1) f) x;;


let fix_memo f x = 
    let tbl = Hashtbl.create 10 in
    let rec aux f x =
        match Hashtbl.find_opt tbl x with
            | Some(y) -> y
            | None -> let res = f (aux f) x in
                let () = Hashtbl.add tbl x res in res
    in aux f x
