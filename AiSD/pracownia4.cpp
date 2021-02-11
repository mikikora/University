#include <stdio.h>
#include <bits/stdc++.h>
#include <vector>
using namespace std;

int comp (const void * elem1, const void * elem2)
{
    int f = *((int*)elem1);
    int s = *((int*)elem2);
    if (f > s) return  1;
    if (f < s) return -1;
    return 0;
}

int med(std::vector<int> T);

int selection(int k, std::vector<int> T, int n) {
    if (n <= 20) {
        sort(T.begin(), T.end());
        return T[k-1];
    }
    int p = med(T);
    std::vector<int> left, right, middle;
    for (int i = 0; i < n; i++) {
        if (T[i] < p) left.push_back(T[i]);
        if (T[i] > p) right.push_back(T[i]);
        if (T[i] == p) middle.push_back(T[i]);
    }
    if (left.size() == k-1) return p;
    else if (k <= left.size()) return selection(k, left, left.size());
    else if (k <= left.size() + middle.size()) return p;
    else return selection(k - (left.size() + middle.size()), right, right.size());
}

int med(std::vector<int> T) {
    std::vector<int> medians;
    for (int i = 0; i < T.size(); i += 5) {
        std::vector<int> five;
        for (int j = i; j < i + 5 && j < T.size(); j++) five.push_back(T[j]);
        sort(five.begin(), five.end());
        medians.push_back(five[five.size() / 2]);
    }
    return selection((medians.size())/2, medians, medians.size());
}

int main () {
    int n, k;
    scanf("%d %d", &n, &k);
    std::vector<int> v;
    for (int i = 0; i < n; i++) {
        int pom;
        scanf("%d", &pom);
        v.push_back(pom);
    }
    int res = selection(k, v, n);
    printf("%d\n", res);
}
