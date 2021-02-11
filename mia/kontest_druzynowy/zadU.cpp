#include <bits/stdc++.h>
using namespace std;


int main () {
    int t;
    cin >> t;
    while (t--) {
        int n;
        cin >> n;
        string a[n], b;
        int count = 0;
        for (int i = 0; i < n; i++) cin >> a[i];
        set<string> left, right;
        for (int i = 0; i < n; i++) {
            cin >> b;
            if (a[i] != b or !left.empty()) {

                auto l = left.find(a[i]);

                if (l != left.end()) {
                    left.erase(l);
                }
                else {
                    right.insert(a[i]);
                }
                auto r = right.find(b);
                if (r != right.end()) {
                    right.erase(r);
                }
                else {
                    left.insert(b);
                }

                // for (auto j:left) cout<<j<<" ";
                // cout<<"\n";
                // for (auto j:right) cout<<j<<" ";

                count++;
            }
            else {
                // cout<<b<<"\n";
                cout<< 1 << " ";
                count = 0;
            }
            if (left.empty() and count) {
                cout<< count<<" ";
            }
            // cout<<"\n";
        }
        cout<<"\n";
        // if (count) cout<<count<<"\n";
        // else cout<<1<<"\n";

    }

    return 0;
}
