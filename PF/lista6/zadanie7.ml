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
