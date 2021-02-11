function fib(n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    return fib(n-1) + fib(n-2);
}

function fibi(n) {
    x = 0;
    y = 1;
    for (let i = 1; i < n; i++) {
        temp = x;
        x = y;
        y = y + temp;
    }
    return y;
}

console.log(fibi(10));

function time(a, b) {
    for (let i = a; i <= b; i++) {
        label = "fib rec "+i;
        console.time(label);
        fib(i);
        console.timeEnd(label);
        label = "fib_iter "+i;
        console.time(label);
        fibi(i);
        console.timeEnd(label);
        console.log("");
    }
}

time(10, 40);

