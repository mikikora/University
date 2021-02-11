function fib(n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    return fib(n-1) + fib(n-2);
};

function memoize(f) {
    var cache = {};
    return function(n) {
        if (n in cache) {
            return cache[n];
        } else {
            var result = f(n);
            cache[n] = result;
            return result;
        };
    };
    
};

function time(f, a, b) {
    for (var i = a; i <= b; i++) {
        label = i;
        console.time(label);
        f(i);
        console.timeEnd(label);
    }
};


time(fib, 30, 40);
var memo = memoize(function(n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    return memo(n-1) + memo(n-2)
});
console.log('');
time(memo, 30, 40);

