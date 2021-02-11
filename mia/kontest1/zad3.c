#include <stdio.h>
#define INF 10000000
#define MOD sum %= 1000000007
#define CLU [(j+i)%n][j]
#define CLD [(n-j-1+i)%n][j]
#define CRU [(j+i)%n][n-j-1]
#define CRD [(n-j-1+i)%n][n-j-1]

int main () {
    int n;
    scanf("%d\n", &n);
    int board[n][n];
    int zeros_p[n][n];
    int zeros_x[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            char c;
            scanf("%c", &c);
            board[i][j] = c-48;
            zeros_p[i][j] = board[i][j] == 0 ? 0 : INF;
            zeros_x[i][j] = board[i][j] == 0 ? 0 : INF;
        }
        char trash;
        scanf("%c", &trash);
    }
    //obliczanie zer
    int cr=INF, cl=INF, cu=INF, cd=INF;
    for (int i = 0; i < n; i++) { //lewo prawo
        for (int j = 0; j < n; j++) {
            if (board[i][j] == 0) cl = 0;
            else {
                if (zeros_p[i][j] > ++cl) zeros_p[i][j] = cl;
            }
            if (board[i][n-j-1] == 0) cr = 0;
            else {
                if (zeros_p[i][n-j-1] > ++cr) zeros_p[i][n-j-1] = cr;
            }
        }
        cl=cr=INF;
    }
    for (int j = 0; j < n; j++) { //gora dol
        for (int i = 0; i < n; i++) {
            if (board[i][j] == 0) cu = 0;
            else {
                if (zeros_p[i][j] > ++cu) zeros_p[i][j] = cu;
            }
            if (board[n-i-1][j] == 0) cd=0;
            else {
                if (zeros_p[n-i-1][j] > ++cd) zeros_p[n-i-1][j] = cd;
            }
        }
        cd=cu=INF;
    }
    //skosy
    int clu=INF, cld=INF, cru=INF, crd=INF;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (j+i == n) clu = cru = INF;
            if (n-j-1+i == n+1) cld = crd = INF;
            if (board CLU == 0) clu = 0;
            else {
                if (zeros_x CLU > ++clu) zeros_x CLU = clu;
            }
            if (board CLD == 0) cld = 0;
            else {
                if (zeros_x CLD > ++cld) zeros_x CLD = cld;
            }
            if (board CRD == 0) crd = 0;
            else {
                if (zeros_x CRD > ++crd) zeros_x CRD = crd;
            }
            if (board CRU == 0) cru = 0;
            else {
                if (zeros_x CRU > ++cru) zeros_x CRU = cru;
            }
            // if ((j+i)%n == 1 && j == 1) printf("clu: %d\n", clu);
            // if ((j+i)%n == 1 && n-j-1 == 1) printf("cru: %d\n", cru);
            // if ((n-j-1+i)%n == 0 && j == 1) printf("cld: %d\n", cld);
            // if ((n-j-1+i)%n == 1 && n-j-1 == 1) printf("crd: %d\n", crd);
        }
        clu = crd = cld = cru = INF;
    }


    double b[n][n]; //logarytmty
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            switch (board[i][j]) {
                case 0:
                    b[i][j] = -INF;
                    break;
                case 1:
                    b[i][j] = 0.0;
                    break;
                case 2:
                    b[i][j] = 1.0;
                    break;
                case 3:
                    b[i][j] = 1.6;
                    break;
                default:
                    printf("%d\n", board[i][j]);
                    printf("ERROR");
                    return 0;
                    break;
            }
        }
    }
    long double smx=0.0;
    int xmx, ymx, cross=0;

    for (int i = 0; i < n; i++) { //maximum plus
        for (int j = 0; j < n; j++) {
            long double sum = .0;
            for (int k = 1; k < zeros_p[i][j]; k++) {
                if (j+k >= n || j-k <0) break;
                sum += b[i][j+k];
                sum += b[i][j-k];
                sum += b[i+k][j];
                sum += b[i-k][j];
            }
            sum += b[i][j];
            if (smx < sum) {smx = sum; xmx = i; ymx = j;}
        }
    }
    for (int i = 0; i < n; i++) { //maxumium skos
        for (int j = 0; j < n; j++) {
            long double sum = .0;
            for (int k = 1; k < zeros_x[i][j]; k++) {
                if (i + k >= n || j+k >=n || i-k < 0 || j-k < 0) break;
                sum += b[i+k][j+k];
                sum += b[i+k][j-k];
                sum += b[i-k][j+k];
                sum += b[i-k][j-k];
            }
            sum += b[i][j];
            if (smx < sum) {smx = sum; xmx = i; ymx = j; cross=1;}
        }
    }

    // printf("%Lf\n", smx);
    long long int sum=1;
    if (!cross) { //maximum jezeli w plusie
        for (int k = 1; k < zeros_p[xmx][ymx]; k++) {
            sum *= ymx+k < n ? board[xmx][ymx+k] : 1;
            MOD;
            sum *= ymx-k >=0 ? board[xmx][ymx-k] : 1;
            MOD;
            sum *= xmx+k < n ? board[xmx+k][ymx] : 1;
            MOD;
            sum *= xmx-k >=0 ? board[xmx-k][ymx] : 1;
            MOD;
        }
    }
    else {
        for (int k = 1; k < zeros_x[xmx][ymx]; k++) {
            if (xmx + k < n && ymx + k < n) sum *= board[xmx+k][ymx+k];
            MOD;
            if (xmx + k < n && ymx - k >= 0) sum *= board[xmx+k][ymx-k];
            MOD;
            if (xmx - k >= 0 && ymx + k < n) sum *= board[xmx-k][ymx+k];
            MOD;
            if (xmx - k >= 0 && ymx - k >=0) sum *= board[xmx-k][ymx-k];
            MOD;
        }
    }
    sum *= board[xmx][ymx];
    MOD;
    printf("%lld\n", sum);

    // printf("\n\n");
    // for (int i = 0; i < n; i++) {
    //     for (int j = 0; j < n; j++) {
    //         printf("%d ", board[i][j]);
    //     }
    //     printf("\n");
    // }
    // printf("\n");
    // for (int i = 0; i < n; i++) {
    //     for (int j = 0; j < n; j++) {
    //         printf("%d ", zeros_p[i][j]);
    //     }
    //     printf("\n");
    // }
    // printf("\n");
    // for (int i = 0; i < n; i++) {
    //     for (int j = 0; j < n; j++) {
    //         printf("%lf ", b[i][j]);
    //     }
    //     printf("\n");
    // }
}
