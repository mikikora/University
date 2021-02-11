#include <stdio.h>

int main() {
    int n;
    scanf("%d\n", &n);
    bool tab[5001];
    for (int i = 0; i < 5001; i++) tab[i] = false;
    int sum = 0;
    for (int i = 0; i < n; i++) {
        int el;
        scanf("%d", &el);
        tab[el] = true;
    }
    for (int i = 1; i <= n; i++) {
        if (!tab[i]) sum++;
    }
    printf("%d", sum);
}
