#include <stdio.h>

int a, b;

int main () {
    scanf("%d %d", &a, &b);
    if (a > b) {
        int temp = a;
        a = b;
        b = temp;
    }
    for (int i = a; i <= b; i++) printf("%d\n", i);
}
