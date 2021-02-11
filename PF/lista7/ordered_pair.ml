module type OrderedType = sig
    type t
    val compare: t -> t -> int
end

module Make(Key : OrderedType) = struct
    type t = Key.t * Key.t

    let compare t1 t2 =
        if Key.compare (fst t1) (fst t2) = 0
            then Key.compare (snd t1) (snd t2)
            else Key.compare (fst t1) (fst t2)

end
