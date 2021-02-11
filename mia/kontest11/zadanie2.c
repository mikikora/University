#include <stdio.h>
#define FOR(i,n) for (int i = 0; i < n; i++)
#define ld (long double)

int main() {
    int n,m,h;
    scanf("%d %d %d", &n, &m, &h);
    int rest = 0, his;
    FOR(i,m) {
        if (i == h-1) scanf("%d", &his);
        else {
            int tmp;
            scanf("%d", &tmp);
            rest += tmp;
        }
    }
    int all = rest + his;
    //printf("%d\n", all);
    if (all < n) {
        printf("-1\n");
        return 0;
    }
    long double res = 1.;
    for (int i = 1; i < n; i++) {
        long double next = (ld rest - ld n + (ld i + 1)) / (ld all - ld n + ld i);
        //long double licznik = (ld rest - ld n + (ld i + 1));
        //long double mianownik = ld all - ld n + ld i;
        //printf("%LF\t%LF\t%LF\n", licznik, mianownik, next);
        res = res * next;
    }
    printf("%LF\n", 1.0-res);
}
    

