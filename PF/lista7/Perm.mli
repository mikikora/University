module type OrderedType = sig
    type t
    val compare : t -> t -> int
end

module type S = sig
    type key
    type t
    (** permutacja jako funkcja *)
    val apply : t -> key -> key
    (** permutacja identycznościowa *)
    val id : t
    (** permutacja odwrotna *)
    val invert : t -> t
    (** permutacja która tylko zamienia dwa elementy miejscami *)
    val swap : key -> key -> t
    (** złożenie permutacji (jako złożenie funkcji) *)
    val compose : t -> t -> t
    (** porównywanie permutacji *)
    val compare : t -> t -> int
end

module Make(Key : OrderedType) : S with type key = Key.t

module type S2 = sig
    type t
    val is_generated: t -> t list -> bool
end

module MakeGenerated(Perm: S) : S2 with type t = Perm.t
