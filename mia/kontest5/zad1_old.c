#include <stdio.h>

int main() {
    int n, k;
    scanf("%d %d", &n, &k);
    int idx=0;
    int tab[k];
    int min_suma=0;
    for (int i = 0; i < k; i++) { scanf("%d", &tab[i]); min_suma += tab[i];}
    int suma=min_suma;
    for (int i=k; i<n; i++) {
        int new;
        scanf("%d", &new);
        if (suma - tab[0] + new < min_suma) { idx = i - (k-1); min_suma = suma - tab[0] + new; }
        suma = suma - tab[0] + new;
        for (int j = 0; j < k-1; j++) tab[j]=tab[j+1];
        tab[k-1] = new;
    }
    printf("%d", idx+1);

    return 0;
}
