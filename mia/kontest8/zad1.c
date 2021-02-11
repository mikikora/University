
#include <stdio.h>
 
long long int Npo2(long long int n) {
    return n * (n-1) / 2;
}
 
int main () {
    long long int n, d;
    scanf("%lld %lld", &n, &d);
    long long int tab[n];
    for (long long int i = 0; i < n; i++) scanf("%lld", &tab[i]);
    long long int l = -1;
    long long int r = 1;
    long long res = 0;
    while (l++ < n ) {
        //printf("%d\n", l);
        while (tab[r] - tab[l] <= d && r < n) r++;
        //printf("%d\t%d\n", r, r-l);
        if (r - l >= 2) res += Npo2(r-l-1);
    }
    
    printf("%lld", res);
    return 0;
}
