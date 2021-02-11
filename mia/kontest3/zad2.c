#include <stdio.h>


int main() {
    int n;
    scanf("%d\n", &n);
    int tab[2*n+1][2*n];
    for (int i = 0; i < 2*n+1; i++) {
        for (int j = 0; j < 2*n; j++) tab[i][j] = 0;
    }
    for (int i = 2; i <= 2*n; i++) {
        for (int j = 1; j < i; j++) {
            scanf("%d", &tab[i][j]);
        }
    }
    int pairs[2*n+1];
    for (int i = 0; i < 2*n+1; i++) pairs[i] = 0;
    for (int k = 0; k < n; k++) {
        int max_i, max_j, max_val=0;
        for (int i = 2; i <= 2*n; i++) {
            for (int j = 1; j < i; j++) {
                if (tab[i][j] > max_val) {
                    max_val = tab[i][j];
                    max_i = i;
                    max_j = j;
                }
            }
        }
        // printf("%d %d %d\n", max_val, max_i, max_j);
        pairs[max_i] = max_j;
        pairs[max_j] = max_i;
        for (int i = 2; i <= 2*n; i++) {
            for (int j = 1; j < i; j++) {
                if (i == max_i || j == max_j || i == max_j || j == max_i) tab[i][j] = 0;
            }
        }

    }
    for (int i = 1; i <= 2*n; i++) {
        printf("%d ", pairs[i]);
    }
}
