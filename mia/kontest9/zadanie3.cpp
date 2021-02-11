#include <stdio.h>
#include <map>
#define ll long long int
#define rem 1000000007
using namespace std;

ll pow(ll x, ll n) {
    if (n == 0) return 1;
    if (n % 2 == 0) {
        ll a = pow(x, n/2);
        return (a * a) % rem;
    }
    return (x * pow(x, n-1)) % rem;
}

int main() {
    int n;
    ll x, exp = 0;
    scanf("%d %Ld", &n, &x);
    ll a[n];
    for (int i = 0; i < n; i++) {
        ll temp;
        scanf("%Ld", &temp);
        exp += temp;
        a[i] = temp;
    }
    map<ll, ll> exps;
    printf("%Ld\n\n", exps[10]);
    for (int i = 0; i < n; i++) {
        //printf("%Ld %Ld", exp, a[i]);
        exps[exp - a[i]]++;
    }
    for (auto [key, value] : exps) {
        if (value >= x) {
            exps[key+1] += value/x;
            exps[key] = value % x;
        }
    }
    /*
    for (auto [key, value] : exps) {
        printf("%Ld %Ld\n", key, value);
    }
    */
    for (auto [key, value] : exps) {
        if (value == 0) continue;
        printf("%Ld", pow(x, key));
        break;
    }
    return 0;
}
