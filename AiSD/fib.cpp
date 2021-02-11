#include <stdio.h>
#include <vector>
using namespace std;

std::vector<long long> mult_matrix(std::vector<long long> a, std::vector<long long> b, int m) {
    std::vector<long long> res(4);
    res[0] = (a[0] * b[0] + a[1] * b[2]) % m;
    res[1] = (a[0] * b[1] + a[1] * b[3]) % m;
    res[2] = (a[2] * b[0] + a[3] * b[2]) % m;
    res[3] = (a[2] * b[1] + a[3] * b[3]) % m;
    return res;
}

std::vector<long long> fast_matrix_power(std::vector<long long> a, int n, int m) {
    if (n == 0) {
        a[0] = a[3] = 1;
        a[1] = a[2] = 0;
        return a;
    }
    if (n == 1) return a;
    std::vector<long long> temp = fast_matrix_power(a, n/2, m);
    if (n % 2 == 0) {
        return mult_matrix(temp, temp, m);
    }
    else {
        return mult_matrix(mult_matrix(temp, temp, m), a, m);
    }
}

long long find_fib(int a, int m) {
    std::vector<long long> v(4,1); v[3] = 0;
    return fast_matrix_power(v, a, m)[1];
}

int main () {
    int n;
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        int a, m;
        scanf("%d %d", &a, &m);
        printf("%d\n", find_fib(a, m));
    }

    return 0;
}
