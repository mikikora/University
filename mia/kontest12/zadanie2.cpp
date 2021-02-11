#include <stdio.h>
#include <vector>


int main () {
    int n, m;
    scanf("%d %d", &n, &m);
    int tab[m][2];
    for (int i = 0; i < m; i++) {
        scanf("%d %d", &tab[i][0], &tab[i][1]);
    }
    if (n != m) { 
        printf("NO");
        return 0;
    }

    std::vector<int> stack = { tab[0][0] };
    int seen[n+1];
    for (int i = 0; i <= n; i++) {
        seen[i] = 0;
    }
    while (!stack.empty()) {
        int el = stack[stack.size() - 1];
        stack.pop_back();
        if (seen[el] != 0) continue;
        seen[el] = 1;
        for (int i = 0; i < m; i++) {
            if (tab[i][0] == el && seen[tab[i][1]] == 0) {
                stack.push_back(tab[i][1]);
                continue;
            }
            if (tab[i][1] == el && seen[tab[i][0]] == 0) {
                stack.push_back(tab[i][0]);
                continue;
            }
        }
    }
    for (int i = 1; i <= n; i++) {
        if (seen[i] == 0) {
            printf("NO");
            return 0;
        }
    }
    printf("FHTAGN!");
    return 0;
}

    
