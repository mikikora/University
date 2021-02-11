#include <stdio.h>
#define ll long long int
#define MAX 100001
#define ZERO(x, n) for (int i = 0; i < n; i++) x[i] = 0;

int main() {
    ll A[MAX]; ZERO(A, MAX)
    ll operations[MAX][3]; 
    ll query[MAX]; ZERO(query, MAX)
    ll changes[MAX]; ZERO(changes, MAX)
    int n,m,k;
    scanf("%d %d %d", &n, &m, &k);
    for (int i = 1; i <= n; i++) {
        scanf("%lld", &A[i]);
    }
    for (int i = 1; i <= m; i++) {
        for (int j = 0; j < 3; j++) {
            scanf("%lld", &operations[i][j]);
        }
    }
    for (int i = 0; i < k; i++) {
        ll a, b;
        scanf("%d %d", &a, &b);
        query[a]++;
        query[b+1]--;
    }
    ll tmp = 0;
    for (int i = 1; i <= m; i++) {
        tmp += query[i];
        changes[operations[i][0]] += tmp * operations[i][2];
        changes[operations[i][1]+1] -= tmp * operations[i][2];
    }
    tmp = 0;
    for (int i = 1; i <= n; i++) {
        tmp += changes[i];
        printf("%lld ", A[i] + tmp);
    }
    return 0;
}

