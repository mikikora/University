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


module Make(Key : OrderedType) = struct

    module Sig = Map.Make(Key)
    type key = Key.t

    type t = Sigma of (key Sig.t * key Sig.t) 

    let apply t k = let Sigma(f, _) = t in match Sig.find_opt k f with
        | Some(x) -> x
        | None -> k

    let id = Sigma(Sig.empty, Sig.empty)

    let invert t = let Sigma(f1, f2) = t in Sigma(f2,f1)

    let swap k1 k2 = if Key.compare k1 k2 = 0 then id
        else let m1 = Sig.add k1 k2 (Sig.empty) in let m1 = Sig.add k2 k1 m1 in
        let m2 = Sig.add k1 k2 (Sig.empty) in let m2 = Sig.add k2 k1 m2 in
        Sigma(m1, m2)

    let compose t1 t2 = let Sigma(f11, f12), Sigma(f21, f22) = t1, t2 in
        let f perm key a b = match a, b with
            | Some(x), Some(_) 
            | Some(x), None -> let y = apply perm x in if Key.compare key y = 0 then None else Some(y)
            | None, Some(_) -> b
            | None, None -> None
        in let m1 = Sig.merge (f t1) f21 f11 and m2 = Sig.merge (f t2) f12 f22 in
        Sigma(m1, m2)

    let compare t1 t2 = let Sigma(f1, _), Sigma(f2, _) = t1, t2 in
        Sig.compare Key.compare f1 f2

end


module type S2 = sig
    type t
    val is_generated: t -> t list -> bool
end


module MakeGenerated(Perm : S) = struct
    type t = Perm.t

    module PermSet = Set.Make(Perm)

    let is_generated perm perms = 
        let rec aux xsset = 
            let rec auxx xs = 
                match xs with
                    | [] -> PermSet.empty
                    | hd::tl -> PermSet.union (PermSet.map (function x -> Perm.compose hd x) xsset) (auxx tl)
            in
            let new_perms = PermSet.union (PermSet.union xsset (PermSet.map (function x -> Perm.invert x) xsset))
                (auxx (PermSet.elements xsset) )
            in if PermSet.compare xsset new_perms = 0 
                then match PermSet.find_opt perm new_perms with
                    | Some(_) -> true
                    | None -> false
                else aux new_perms
        in aux (PermSet.union (PermSet.of_list perms) (PermSet.singleton Perm.id))

end


















