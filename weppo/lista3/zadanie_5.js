function sum (...a ) {
    var s = 0;
    for (var e of a) {
        s += e;
    }
    return s;
}

console.log(sum(1,2,3,4,5,6));
