#include <stdio.h>

unsigned long long powMod(unsigned long long a, unsigned int b, unsigned int m) {
    a = a % m;
    if (b == 0) return 1u;
    if (b == 1) return a;
    if (b % 2 == 0) {
        unsigned long long temp = powMod(a, b/2, m);
        return (temp * temp) % m;
    }
    else {
        unsigned long long temp = powMod(a, b-1, m);
        return (temp * a) % m;
    }
}


int main () {
    int n;
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        unsigned int a, b, m;
        scanf("%d %d %d", &a, &b, &m);
        printf("%d ", powMod(a, b, m));
    }
}
