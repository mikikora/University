#include <stdio.h>

int binSearch (int t[], int a, int b, int x) {
    if (b <= a)  return a;
    int m = (a + b) / 2;
    if (t[m] == x) return m;
    if (t[m] > x) return binSearch(t, a, m-1, x);
    return binSearch(t, m+1, b, x);
}

int main () {
    int n, m;
    scanf("%d", &n);
    int tab[n];
    for (int i = 0; i < n; i++) {
        scanf("%d", &tab[i]);
    }
    scanf("%d", &m);
    for (int i = 0; i < m; i++) {
        int x;
        scanf("%d", &x);
        int w;
        if (tab[0] > x) w = 0;
        else if (tab[n-1] < x) w = n;
        else {
            w = binSearch(tab, 0, n-1, x);
            if (tab[w] < x) w++;
            while (tab[w-1] == tab[w]) w--;
        }
        printf("%d ", n-w);
    }
    return 0;
}
