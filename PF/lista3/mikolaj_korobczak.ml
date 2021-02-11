
(* Zadanie 1 *)
let xs = [1;2;3;4];;

let length xs = List.fold_left (fun x y -> x+1) 0 xs ;;
let rev xs = List.fold_left (fun x y -> y::x) [] xs;;
let map f xs = List.fold_right (fun x y -> (f x)::y) xs [] ;;
let append xs ys = List.fold_right (fun x y -> x::y) xs ys;;
let rev_append xs ys = List.fold_left (fun x y -> y::x) ys xs;;
let filter f xs = List.fold_right (fun x y -> if f x then x::y else y) xs [];;
let rev_map f xs = List.fold_left (fun x y -> (f y)::x) [] xs;;

(* Zadanie 2 *)
let list_to_int_fold xs = List.fold_left (fun x y -> y + (10 * x)) 0 xs;;
let list_to_int_rec xs = 
    let rec aux acc xs = 
        match xs with
            | [] -> acc
            | hd::tl -> aux (hd + (acc * 10) ) tl
    in aux 0 xs;;

(* Zadanie 3 *)
let polynomian_fold xs x = List.fold_left (fun a b -> (b +. (x *. a))) 0. xs ;;
let polynomian_rec xs x = 
    let rec aux acc xs = 
        match xs with
            | [] -> acc
            | hd::tl -> aux (hd +. (x *. acc)) tl
    in aux 0. xs;;


(* Zadanie 4 *)
let rec rev_polynomian_a xs x = 
    match xs with
        | [] -> 0.
        | hd::tl -> hd +. (x *. rev_polynomian_a tl x) ;;

let rev_polynomian_fr xs x = List.fold_right (fun a b -> (a +. (x *. b))) xs 0.;;
let rev_polynomian_c xs x = 
    let rec aux acc xs y = 
        match xs with
            | [] -> acc
            | hd::tl -> aux ((hd *. y) +. acc) tl (y *. x)
    in aux 0. xs 1.;;

let rev_polynomian_fl xs x = let temp = List.fold_left (fun (acc, y) b -> ((b *. y) +. acc, y *. x)) (0., 1.) xs in fst temp;;

(* Zadanie 5 *)
exception False_in_array;;
let for_all f xs = 
    try List.fold_left (fun acc x -> if f x then acc else raise (False_in_array)) true xs
    with False_in_array -> false;;

exception Zero_in_array;;
let mult_list xs = 
    try List.fold_left (fun acc x -> if x = 0 then raise (Zero_in_array) else acc * x) 1 xs
    with Zero_in_array -> 0;;

exception Lower_in_array;;
let sorted xs =
    match xs with
        | [] -> true
        | hd::tl -> try snd @@ List.fold_left (fun (acc, b) x -> if x < acc then raise (Lower_in_array) else (x, true)) (hd, true) tl
    with Lower_in_array -> false;;

(* Zadanie 6 *)
let rec fold_right_cps f acc xs k = 
    match xs with
        | [] -> k acc
        | hd::tl -> let k = fun v -> f v hd k in fold_right_cps f acc tl k;;

let fold_left_cps f acc xs k = 
    let rec aux g xs = 
        match xs with
            | [] -> k acc
            | [x] -> g acc x k
            | hd::tl -> let h = fun acc x k -> g acc hd (fun a -> f a x k) in 
                aux h tl
    in aux f xs

let fold_left f acc xs = 
    fold_left_cps (fun acc x k -> k (f acc x)) acc xs (fun x -> x);;

(* Zadanie 7 *)

let for_all_cps f xs = fold_left_cps (fun acc x k -> if f x then k acc else false) true xs (fun x -> x);;
let mult_list_cps xs = fold_left_cps (fun acc x k -> if x = 0 then 0 else k (acc * x)) 1 xs (fun x -> x);;
let sorted_cps xs = match xs with
    | [] -> true
    | hd::tl -> fold_left_cps (fun acc x k -> if x < acc then false else k x) hd tl (fun _ -> true);;


(* Zadanie 8 *)
let rec map f k = 
    recv (fun v -> send (f v) (fun () -> map f k));;


let rec filter f k =
    recv (fun v -> if (f v) then send v (fun () -> filter f k) else filter f k);;

let rec nats_from n k =
    send n (fun () -> nats_from (n+1) k);;
(* wywołanie *)
(* run (nuts_from 0 k <|>> string_of_int);; *)

let rec sieve k =
    recv (fun v -> send v (fun () -> (filter (fun x -> x mod v <> 0) <|>> sieve) k ));;

