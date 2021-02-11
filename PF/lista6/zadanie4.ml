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
