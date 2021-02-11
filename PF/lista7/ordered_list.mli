module type OrderedType = sig
    type t
    val compare : t -> t -> int
end


module Make(Key : OrderedType) : OrderedType with type t = Key.t list

