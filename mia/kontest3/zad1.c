#include <stdio.h>
#include <stdbool.h>

bool distinct(int n) {
    bool t[10];
    for (int i = 0; i < 10; i++) t[i] = false;
    while (n > 0) {
        if (t[n%10]) return false;
        t[n%10] = true;
        n /= 10;
    }
    return true;
}

int main() {
    int n;
    scanf("%d", &n);
    n += 1;
    while (true) {
        if (distinct(n)) {
            printf("%d", n);
            break;
        }
        n += 1;
    }
}
