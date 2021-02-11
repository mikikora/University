#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, m;
    cin >> n >> m;
    vector<int> people[n+1], language[m+1];
    bool all_zeros = true;
    for (int i = 1; i <= n; i++) {
        int pers;
        cin >> pers;
        if (pers) all_zeros = false;
        for (int j = 1; j <= pers; j++) {
            int lang;
            cin >> lang;
            people[i].push_back(lang);
            language[lang].push_back(i);
        }
    }
    if (all_zeros) {
        cout << n;
        return 0;
    }
    bool graph[n+1][n+1];
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            graph[i][j] = false;
        }
        graph[i][i] = true;
    }
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < people[i].size(); j++) {
            for (int k = 0; k < language[people[i][j]].size(); k++) {
                graph[i][language[people[i][j]][k]] = true;
            }
        }
    }
//    for (int i = 1; i <= n; i++) {
//        for (int j = 1; j <= n; j++) {
//            cout << i << j << graph[i][j] << endl;
//        }
//    }
    
    bool seen[n+1];
    for (int i = 1; i <= n; i++) seen[i] = false;
    int seen_count = 0;
    int spojne_skladowe = 0;
    while (seen_count < n) {
        spojne_skladowe++;
        vector<int> stack;
        for (int i = 1; i <= n; i++) {
            if (!seen[i]) {
                stack.push_back(i);
                break;
            }
        }
        while (stack.size()) {
            int next = stack.back();
            stack.pop_back();
            if (seen[next]) continue;
            seen[next] = true;
            seen_count++;
            for (int i = 1; i <= n; i++) {
                if (graph[next][i] && !seen[i]) stack.push_back(i);
            }
        }
    }
    cout << spojne_skladowe-1;




    return 0;

    
}
