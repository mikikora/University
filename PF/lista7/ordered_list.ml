module type OrderedType = sig
    type t
    val compare : t -> t -> int
end

module Make(Key : OrderedType) = struct
    type t = Key.t list

    let rec compare t1 t2 = 
        match t1, t2 with
            | x::xs, y::ys -> if Key.compare x y = 0 then compare xs ys else Key.compare x y
            | [], [] -> 0
            | [], _ -> -1
            | _, [] -> 1

end

