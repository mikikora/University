#include <stdio.h>
#define ull unsigned long long int

int main() {
    ull n;
    scanf("%lld", &n);
    if (n % 2 == 1) printf("1");
    else printf("2");
    return 0;
}
