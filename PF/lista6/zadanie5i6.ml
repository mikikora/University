type 'a dllist = 'a dllist_data lazy_t
and 'a dllist_data =
    { prev : 'a dllist
    ; elem : 'a
    ; next : 'a dllist
    }


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
