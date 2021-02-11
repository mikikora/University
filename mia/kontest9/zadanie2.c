#include <stdio.h>
#include <stdbool.h>
#define FOR(i, a, n) for (int i = a; i < n; i++)

bool prime[1000001];
int sums[1000001];

bool good(int a, int b, int k, int l) {
  for (int i = a; i <= b-l+1;i++) {
    /* printf("\n%d %d %d\n", i+l-1, sums[i+l-1], sums[i-1]); */
    if (sums[i+l-1] - sums[i-1] < k) return false;
  }
  return true;
}

int binsearch(int a, int b, int l, int r, int k) {
  /* printf("%d %d\n", l, r); */
  if (r < l) return -1;
  int s = (l + r)/2;
  if (good(a, b, k, s)) {
    int possible_better = binsearch(a, b, l, s-1, k);
    if (possible_better != -1) return possible_better;
    else return s;
  }
  return binsearch(a, b, s+1, r, k);
}

int main () {
  int a, b, k;
  scanf("%d %d %d", &a, &b, &k);
  FOR(i, 0u, b+1) {
    prime[i] = true;
  }
  
  prime[0] = prime[1] = false;
  FOR(i, 0, b+1) {
    if (prime[i]) {
      for (int j = i+i; j <= b; j += i) prime[j] = false;
    }
  }

  sums[0] = 0;
  FOR(i, 1, b+1) {
    if (prime[i])
      sums[i] = sums[i-1] + 1;
    else
      sums[i] = sums[i-1];
  }
  int res = binsearch(a, b, 1, b-a+1, k);
  /* printf("%d\n", res); */
  if (res <= b-a+1) printf("%d", res);
  else printf("-1");

  return 0;
}
