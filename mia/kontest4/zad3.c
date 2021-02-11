#include <stdio.h>

unsigned long long int min(unsigned long long int a, unsigned long long int b) {
    return a < b ? a : b;
}

unsigned long long int binsearch(unsigned long long int l, unsigned long long int r, unsigned long long int k, unsigned long long int n, unsigned long long int m) {
    if (l >= r) return l;
    unsigned long long int mid = (l+r)/2;
    unsigned long long int s = 0;
    for (int i = n; i > 0; i--) {
        s += min(mid / i, m);
    }
    if (s >= k) return binsearch(l, mid, k, n, m);
    return binsearch(mid+1, r, k, n, m);
}


int main() {
    unsigned long long int n, m, k;
    scanf("%llu %llu %llu", &n, &m, &k);
    printf("%llu\n", binsearch(1, n*m, k, n, m));


    return 0;
}
