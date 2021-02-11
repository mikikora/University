#include <stdio.h>
#define INFINITY 9000000
#define MINFINITY -9000000

int main() {

    int F, C;
    scanf("%d\n%d", &F, &C);
    int p[C];
    int w[C];
    for (int i = 0; i < C; i++) {
        scanf("%d %d", &p[i], &w[i]);
    }
    int coinmin[F+1];
    for (int i = 0; i<F+1; i++) coinmin[i] = -1;
    long long mint[F+1];
    for (int i=1; i<F+1; i++) {mint[i] = INFINITY;}
    mint[0] = 0;


    for (int i = 1; i < C+1; i++) {
        for (int j = 0; j < F+1; j++) {
            if (j+w[i-1] > F) break;
            if (mint[j] == INFINITY) continue;
            int tempn = mint[j] + p[i-1];
            if (tempn < mint[j+w[i-1]]) {
                mint[j+w[i-1]] = tempn;
                coinmin[j+w[i-1]] = i-1;
            }
        }
    }
    if (mint[F] == INFINITY) {
        printf("NIE\n");
    }
    else {
        printf("TAK\n");
        printf("%lld\n", mint[F]);
        int amount[C], t=F;
        for (int i = 0; i < C; i++) amount[i] = 0;
        while(t > 0) {
            amount[coinmin[t]]++;
            t -= w[coinmin[t]];
        }
        for (int i = 0; i < C; i++) printf("%d ", amount[i]);

        //teraz dla max
        for (int i = 0; i<F+1; i++) coinmin[i] = -1;
        for (int i=1; i<F+1; i++) {mint[i] = MINFINITY;}
        mint[0] = 0;
        for (int i = 1; i < C+1; i++) {
            for (int j = 0; j < F+1; j++) {
                if (j+w[i-1] > F) break;
                if (mint[j] == MINFINITY) continue;
                int tempn = mint[j] + p[i-1];
                if (tempn > mint[j+w[i-1]]) {
                    mint[j+w[i-1]] = tempn;
                    coinmin[j+w[i-1]] = i-1;
                }

            }
        }

        printf("%lld\n", mint[F]);
        t=F;
        for (int i = 0; i < C; i++) amount[i] = 0;
        while(t > 0) {
            amount[coinmin[t]]++;
            t -= w[coinmin[t]];
        }
        for (int i = 0; i < C; i++) printf("%d ", amount[i]);
    }
    printf("\n");

    return 0;
}
