#include <stdio.h>
#include <bits/stdc++.h> 
using namespace std;

int main() {
    int n;
    scanf("%d", &n);
    int p = 0;
    for (; p * p <= 2*n; p++);
    int tab[p];
    for (int i = 1; i < p+1; i++) {tab[i-1] = (i * (i+1))/2;}
    for (int i = 0; i < p; i++) {
        if (binary_search(tab, tab+p, n-tab[i])) {
            printf("YES");
            return 0;
        }
    }
    printf("NO");
    return 0;
}

