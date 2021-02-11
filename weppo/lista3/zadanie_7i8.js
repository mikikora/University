function fib () {
    var n = 0;
    var m = 1;
    return {
        next: function () {
            [n, m] = [m, n+m];
            return {
                value: n,
                done: false 
            }
        }
    }
}

function *fibi() {
    var n = 1;
    var m = 1;
    while (1) {
        yield n;
        [n, m] = [m, n+m];
    }
}

/*let it = fib();
for (let _result; _result = it.next(), !_result.done; ) {
    console.log(_result.value );
}
*/

/*for (var e of fibi()) {
    console.log( e );
}*/
//jeżeli w powyższym kodzie zmienimy fibi na fib to dostaniemy błąd

function *take (it, top) {
    for (var i = 0 ; i < top; i++) {
        yield it.next().value;
    }
}

for (var e of take(fibi(), 10)) {
    console.log(e);
}

console.log('');
for (var e of take(fib(), 10)) {
    console.log(e);
}

