#include <stdio.h>


int main () {
    int n, m;
    scanf("%d %d\n", &n, &m);
    char board[n][m];
    int ms[m];
    for (int i = 0; i < m; i++) ms[i] = 0;
    int ns[n];
    for (int i = 0; i < n; i++) ns[i] = 0;
    int max_m=0;
    int max_n=0;
    int walls=0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            scanf("%c", &board[i][j]);
            if (board[i][j] == '*') {
                walls++;
                ms[j]++;
                ns[i]++;
            }
        }
        char trash;
        scanf("%c", &trash);
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (board[i][j] == '*') {
                if (ns[i] + ms[j] -1 == walls) {
                    printf("YES\n%d %d", i+1, j+1);
                    return 0;
                }
            }
            else {
                if (ns[i] + ms[j] == walls) {
                    printf("YES\n%d %d", i+1, j+1);
                    return 0;
                }
            }
        }
    }
    printf("NO");
}
