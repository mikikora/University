#include <stdio.h>
#define ull unsigned long long int

int main() {
    ull n, k;
    scanf("%lld %lld", &n, &k);
    if ((n/k) % 2 == 1) printf("YES");
    else printf("NO");
    return 0;
}
