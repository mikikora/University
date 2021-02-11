module type OrderedType = sig
    type t
    val compare: t -> t -> int
end

module Make(Key : OrderedType) = struct
    type t = Key.t option

    let compare t1 t2 =
        match t1, t2 with
            | Some(x), Some(y) -> Key.compare x y
            | None, Some(_) -> -1
            | Some(_), None -> 1
            | None, None -> 0

end
