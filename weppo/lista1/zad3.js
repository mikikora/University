function is_prime(x) {
    for (i = 2; i*i <= x; i++) {
        if (x % i == 0) {
            return;
        }
    }
    console.log(x);
    return;
}

for (let i = 2; i <= 100; i++) {
    //console.log(i);
    is_prime(i);
}
