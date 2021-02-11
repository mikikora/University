#include <stdio.h>

int main () {
    int a, b;
    scanf("%d %d", &a, &b);
    int m = a > b ? a : b;
    m = 6 - m + 1;
    switch (m) {
        case 2:
            printf("1/3");
            break;
        case 3:
            printf("1/2");
            break;
        case 4:
            printf("2/3");
            break;
        case 6:
            printf("1/1");
            break;
        default:
            printf("%d/6", m);
            break;
    }
    return 0;
}
