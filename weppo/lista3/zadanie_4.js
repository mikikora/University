function createFs(n) { // tworzy tablicę n funkcji
    var fs = []; // i-ta funkcja z tablicy ma zwrócić i
    for ( var i=0; i<n; i++ ) {
        fs[i] =
            function (z) {
                return function() {
                    return z;
                };
            }(i);
        }
    return fs;
}

//Dzieje się tak ponieważ funkcje wewnętrzne w swoim domknięciu patrzą cały czas na tę samą zmienną i, która w trakcie trwania fora zmienia swoją wartość. 
//Poprawa jest napisaniem słowa kluczowego let za pomocą funckji, ponieważ var działa w odległości jednej funkcji.

var myfs = createFs(10);
console.log( myfs[0]() ); // zerowa funkcja miała zwrócić 0
console.log( myfs[2]() ); // druga miała zwrócić 2
console.log( myfs[7]() );
// 10 10 10
