function forEach(a, f) {
    for (var e of a) {
        f(e);
    }
};

function map(a, f) {
    for (var i = 0; i < a.length; i++) {
        a[i] = f(a[i]);
    }
    return a;
}

function filter(a, f) {
    var res = [];
    for (var e of a) {
        if (f(e)) {
            res.push(e);
        }
    }
    return res;
};
var a = [1,2,3,4];
forEach( a, _ => { console.log( _ ); } );
// [1,2,3,4]
console.log(filter( a, _ => _ < 3 ));
// [1,2]
console.log(map( a, _ => _ * 2 ));
// [2,4,6,8]
