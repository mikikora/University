#include <stdio.h>
#define MOD 1073741824
#define FOR(i, n) for (long long i = 0u; i < n; i++)
#define FORU(i, n) for (long long i = 1u; i <= n; i++)

long long res[1000001];


long long d(long long a) {
  if (res[a] != 0) return res[a];
  for (long long i = 1u; i * i <= a; i++) {
    if (a % i == 0) {
      res[a]++;
      if (i * i != a)
	res[a]++;
    }
  }
  return res[a];
}

int main() {
  int a, b, c;
  scanf("%d %d %d", &a, &b, &c);
  long long res = 0u;
  FORU(i, a) {
    FORU(j, b) {
      FORU(k, c) {
	res += d(i*j*k);
      }
    }
  }
  printf("%lld", res % MOD);
  
  return 0;
}
