#include <stdio.h>

int main() {
    int t;
    scanf("%d\n", &t);
    for (int i = 0; i < t; i++) {
        int n;
        scanf("%d\n", &n);
        int tab[n];
        bool used[2*n+1];
        for (int j = 1; j < 2*n+1; j++) used[j] = false;
        int res[2*n];
        bool good = true;
        for (int j = 0; j < n; j++) {
            scanf("%d", &tab[j]);
            used[tab[j]] = true;
            res[2*j] = tab[j];
        }
        for (int j = 0; j < n; j++) {
            int el;
            int k = res[2*j]+1;
            for (; k <= 2*n; k++) {
                if (!used[k])  {
                    el = k;
                    // printf("%d\n", el);
                    used[k] = true;
                    break;
                }
            }
            if (k > 2*n) {
                good = false;
                break;
            }
            else {
                res[2*j+1] = el;
            }
        }
        if (good) {
            for (int j = 0; j < 2*n; j++) {
                printf("%d ", res[j]);
            }
        }
        else {
            printf("-1");
        }
        printf("\n");
    }
    return 0;
}
