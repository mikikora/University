let next, reset = let cnt = ref 0 in 
    let aux = fun () -> 
        let res = !cnt in
            begin
                cnt := !cnt + 1;
                res
            end
    in aux,
    function () -> cnt := 0;;

    

