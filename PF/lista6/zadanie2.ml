let rec fix f x = f (fix f) x;;

type fixt = Fix of (('a -> 'b) -> 'a -> 'b) * 'a;;
let fix_typed f x = 
    let aux = Fix(f x) in
        
