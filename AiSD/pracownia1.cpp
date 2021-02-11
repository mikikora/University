#include <stdio.h>
#include <set>
#include <vector>
using namespace std;


set<int> seen;

bool dfs(int i, int front[], int mid[], int back[], std::vector<int> graph[]) {
    std::vector<int> q;
    q.push_back(-1);
    q.push_back(i);
    std::vector<int> parentness;
    std::vector<int> parentness_idx;
    int counter = 0;
    bool found = false;
    while (!q.empty()) {
        int x = q.back();
        q.pop_back();
        int parent = q.back(); q.pop_back();
        if (seen.find(back[x]) != seen.end()) continue;
        parentness.push_back(parent);
        parentness_idx.push_back(x);
        if (graph[back[x]].empty()) {
            seen.insert(back[x]);
            counter++;
            continue;
        }
        std::vector<int>::iterator it = graph[back[x]].begin();
        for (;it != graph[back[x]].end(); it++) {
            if (back[*it] == 0) {
                found = true;
                parentness.push_back(counter);
                parentness_idx.push_back(*it);
                break;
            }
            q.push_back(counter); q.push_back(*it);
        }
        seen.insert(back[x]);
        counter++;
        if (found) break;
    }
    // printf("\n");
    //
    // std::vector<int>::iterator its = parentness_idx.begin();
    // for (;its != parentness_idx.end(); ++its) {
    //     printf("%d\n", *its);
    // }
    // printf("\n");

    if (!found) return false;
    // counter = parentness[parentness.size() - 1];
    counter = parentness.size() - 1;
    std::vector<int> order;
    while (counter >= 0) {
        order.push_back(parentness_idx[counter]);
        counter = parentness[counter];
    }
    printf("%d\n", order.size());
    std::vector<int>::reverse_iterator it = order.rbegin();
    for (;it != order.rend(); it++) {
        printf("%d %d %d\n", front[*it], mid[*it], back[*it]);
    }
    return true;
}

int main () {
    int n;
    scanf("%d", &n);
    int front[n], mid[n], back[n];
    std::vector<int> graph[200000];
    // printf("%d\n\n", graph[2].empty());
    for (int i = 0; i < n; i++) {
        scanf("%d %d %d", &front[i], &mid[i], &back[i]);
        graph[front[i]].push_back(i);
    }
    // printf("jest graf\n");

    bool found = false;
    for (int i = 0; i < n; i++) {
        if (front[i] == 0 && dfs(i, front, mid, back, graph)) {
            found = true;
            break;
        }
    }
    if (!found) printf("BRAK");
    // printf("koniec\n");
    return 0;
}
