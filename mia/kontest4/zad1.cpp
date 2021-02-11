#include <stdio.h>
#include <stdlib.h>
#include <bits/stdc++.h> 


int main() {
    int n, m;
    scanf("%d %d", &n, &m);
    int a[n]; 
    for (int i = 0; i < n; i++) scanf("%d", &a[i]);
    std::sort(a, a+n);
    //for (int i = 0; i < n; i++) printf("%d", a[i]);
    for (int i = 0; i < m; i++) {
        int b;
        scanf("%d", &b);
        printf("%d ", std::upper_bound(a, a+n, b)-a);
    }
    return 0;
}

