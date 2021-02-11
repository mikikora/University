#include <stdio.h>

int main() {
    int n, t;
    double p;
    scanf("%d %lf %d", &n, &p, &t);
    double tab[t+1][n+1];
    for (int tk = 0; tk <= t; tk++) {
        for (int nk = 0; nk <= n; nk++) {
            tab[tk][nk] = 0.0;
            if (tk == 0 && nk == 0) {tab[tk][nk] = 1.0; continue;}
            if (tk == 0 && nk != 0) {tab[tk][nk] = 0.0; continue;}
            if (nk == n) {
                tab[tk][nk] += tab[tk-1][nk-1] * p; 
                tab[tk][nk] += tab[tk-1][nk];
                continue;
            }
            if (nk == 0) {
                tab[tk][nk] += tab[tk-1][nk] * (1.0-p);
                continue;
            }
            tab[tk][nk] += tab[tk-1][nk-1] * p;
            tab[tk][nk] += tab[tk-1][nk] * (1.0-p);
        }
    }
    /*
    for (int i = 0; i <= t; i++) {
        for (int j = 0; j <= n; j++) {
            printf("%f\t", tab[i][j]);
        }
        printf("\n");
    }*/
    double exp = 0.0;
    for (int i = 0; i <= n; i++) {
        exp += (double)i * tab[t][i];
    }
    printf("%.9lf", exp);
    return 0;
}
        
    


