function printIfGood(n) {
    sum = 0;
    m = n;
    while (m > 0) {
        sum += m % 10;
        if (n % (m % 10) != 0 ) {
            return;
        }
        m = Math.floor(m / 10);
    }
    if (n % sum != 0) {
        return;
    }
    console.log(n);
}

for (let i = 1; i <= 100000; i++) {
    printIfGood(i);
}

