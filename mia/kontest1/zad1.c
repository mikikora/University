#include <stdio.h>
#define INF 1000000000

int n;

int main () {
    scanf("%d\n", &n);
    char dir[n];
    int pos[n];
    int min = INF;
    for (int i = 0; i < n; i++) {
        scanf("%c", &dir[i]);
    }
    for (int i = 0; i < n; i++) {
        scanf("%d", &pos[i]);
    }
    for (int i = 0; i < n-1; i++) {
        if (dir[i] == 'R' && dir[i+1] == 'L') {
            int temp = (pos[i+1] - pos[i])/2;
            if (temp < min) min = temp;
        }
    }
    if (min == INF) printf("-1");
    else printf("%d", min);

    return 0;
}
