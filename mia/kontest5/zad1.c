#include <stdio.h>

int main() {
    int n, k;
    scanf("%d %d", &n, &k);
    int tab[n];
    for (int i=0; i < n; i++) scanf("%d", &tab[i]);
    int min_sum = 0;
    for (int i = 0; i < k; i++) min_sum += tab[i];
    int suma = min_sum;
    int idx = 0;
    int l=0;
    for (int i = k; i < n; i++) {
        suma = suma - tab[l++] + tab[i];
        if (suma < min_sum) { idx = l; min_sum = suma; }
    }
    printf("%d", idx+1);
    return 0;
}
