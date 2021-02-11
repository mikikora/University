#include <iostream>
#include <algorithm>
#define ll long long int
using namespace std;

int main() {
    int n, q;
    cin >> n >> q;
    ll arr[n];
    ll querys[n];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
        querys[i] = 0;
    }
    for (int i = 0; i < q; i++) {
        int l, r;
        cin >> l >> r;
        querys[l-1]++;
        querys[r]--;
    }
    for (int i = 1; i < n; i++) {
        querys[i] += querys[i-1];
    }
    sort(arr, arr+n);
    sort(querys, querys + n);
    ll sum = 0;
    for (int i = 0; i < n; i++) {
        sum += arr[i] * querys[i];
    }
    cout << sum;
    return 0;
}
