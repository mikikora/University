#include <stdio.h>

int main() {
    int n, t;
    scanf("%d %d", &n, &t);
    int portals[n];
    for (int i = 1; i < n; i++) {
        scanf("%d", &portals[i]);
    }
    int curr = 1;
    while (curr < n) {
        if (curr == t) {
            printf("YES");
            return 0;
        }
        curr += portals[curr];
    }
    if (curr == t) {
        printf("YES");
        return 0;
    }
    printf("NO");
    return 0;
}
