(* Zadanie 1 *)
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
       
(* Zadanie 3 *)
let next, reset = let cnt = ref 0 in 
    let aux = fun () -> 
        let res = !cnt in
            begin
                cnt := !cnt + 1;
                res
            end
    in aux,
    function () -> cnt := 0;;

(* Zadanie 4 *)
type 'a stream = Cons of 'a * (unit -> 'a stream)

let rec take n s = 
    match (n, s) with
        | 0, _ -> []
        | n, Cons(x, xf) -> x :: take (n-1) (xf ())

let rec smap f s = 
    match s with
        | Cons(hd, tl) -> Cons(f hd, fun () -> smap f (tl () ) )

let s1 = 
    let s_pom = 
        let rec aux x = Cons( 1./.x, function () -> aux (if x < 0. then -.x+.2. else -.x-.2.)) in
    aux 1.
    in let rec aux x = Cons( 4. *. (List.fold_right (fun x y -> x +. y) (take x s_pom) 0.), function () -> aux (x+1))
    in aux 1;;


let s2 f s = 
    let rec aux a b s =
        match s with
            | Cons(c, xs) -> Cons((f a b c), function () -> (aux b c (xs ())))
    in
    match s with
        | Cons(x, xs) -> match (xs () ) with
            | Cons(y, ys) -> aux x y (ys ())

let s3 = 
    s2 (fun x y z -> z -. ((y -. z) *. (y -. z)) /. (x -. 2.*.y +. z)) s1 
type 'a dllist = 'a dllist_data lazy_t
and 'a dllist_data =
    { prev : 'a dllist
    ; elem : 'a
    ; next : 'a dllist
    }

(* Zadanie 5 *)
let prev (dlst: 'a dllist) =
    match Lazy.force dlst with
        | {prev=x; elem=_; next=_} -> x

let elem (dlst: 'a dllist) = 
    match Lazy.force dlst with
        | {prev=_; elem=x; next=_} -> x

let next (dlst: 'a dllist) =
    match Lazy.force dlst with
        | {prev=_; elem=_; next=x} -> x

let rec x = lazy ({prev=x; elem=5; next=x});;

let of_list xs =
    match xs with
        | [] -> failwith "Empty list"
        | hd::tl -> 
            let rec aux xs top prev =
                match xs with
                    | [] -> top
                    | hd::tl -> let rec curr = 
                        lazy {prev=prev; elem=hd; next= aux tl top curr}
                        in curr
            in
            let rec find_last xs curr =
                match xs with
                    | [] -> Lazy.force curr
                    | _::tl -> find_last tl (next curr)
            in let rec top =
                lazy {prev = lazy (find_last tl top); elem=hd; next = aux tl top top} in
                top

(* Zadanie 6 *)
let integers = 
    let rec next_e n prev = 
        let rec curr = 
            {prev = lazy prev; elem = n; next = lazy (next_e (n+1) curr)}
            in curr
    in let rec prev_e n next =
        let rec curr =
            {prev = lazy (prev_e (n-1) curr); elem=n; next=lazy next}
            in curr
    in let rec curr =
        {prev = lazy (prev_e (-1) curr); elem=0; next = lazy (next_e 1 curr)}
        in lazy curr


(* Zadanie 7 *)
type 'a my_lazy = {mutable counted: bool; mutable value: 'a option; f: unit -> 'a} 
type 'a my_list = Cons of 'a * ('a my_list my_lazy)

let rec force (f: 'a my_lazy) = 
    if f.counted then 
        match f.value with
            | Some(x) -> x
            | None -> failwith "Non productive lazy expression"
    else
        (f.counted <- true; let x = f.f () in (f.value <- Some(x); x))


let rec fix (f: 'a my_lazy -> 'a) : 'a my_lazy = 
    let rec ans = {counted=false; value=None; f=fun () -> f ans}
    in ans

let primes = 
    let rec primes_stream n (x: 'a my_list my_lazy) =
        let rec next_prime n =
            let m = match n with |1 -> 2 |2 -> 3 |_ -> n+2 in
            let rec aux x m =
                if x = m then true else
                    if x mod m = 0 then false else
                    aux x (m+1)
            in if aux m 2 then m else next_prime m 
    in let next = next_prime n in Cons(next, fix (primes_stream next))
    in fix (primes_stream 1)
