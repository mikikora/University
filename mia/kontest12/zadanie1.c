#include <stdio.h>

int abs(int x) {
    if (x < 0) return -x;
    else return x;
}

int main () {
    int r1, c1, r2, c2;
    scanf("%d %d %d %d", &r1, &c1, &r2, &c2);
    //rook
    if (r1 == r2 || c1 == c2) printf("1 ");
    else printf("2 ");
    //bishop
    if ((r1 + c1) % 2 != (r2 + c2) % 2) {
        printf("0 ");
    }
    else {
        if (abs(r1 - r2) == abs(c1 - c2)) printf("1 ");
        else printf("2 ");
    }
    
    //king
    int a = abs(r1 - r2), b = abs(c1 - c2);
    if (a > b) printf("%d", a);
    else printf("%d", b);

    return 0;
}

