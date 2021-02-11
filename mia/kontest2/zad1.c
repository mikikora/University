#include <stdio.h>


int main() {
    int n;
    scanf("%d\n", &n);
    int a[n], p[n];
    int min_p = 1000, sum=0;
    for (int i = 0; i < n; i++) {
        scanf("%d %d\n", &a[i], &p[i]);
        if (p[i] < min_p) min_p = p[i];
        sum += min_p * a[i];
    }
    printf("%d", sum);
    return 0;
}
