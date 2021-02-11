#include <stdio.h>
#include <math.h>
#include <algorithm>
#include <vector>
#include "utility"
#include <chrono>
#include <iostream>
using namespace std::chrono;
using namespace std;

std::vector<pair<int,int>> vx;
std::vector<pair<int,int>> vy;

bool vector_relation_x(pair<int,int> a, pair<int,int> b) {
    if (a.first == b.first) return a.second < b.second;
    else return a.first < b.first;
}

bool vector_relation_y(pair<int,int> a, pair<int,int> b) {
    return a.second < b.second;
}

double distance(pair<int,int> a, pair<int,int> b) {
    int x = a.first - b.first;
    int y = a.second - b.second;
    return sqrt(x*x + y*y);
}

double obw(pair<int,int> a, pair<int,int> b, pair<int,int> c) {
    double sum = 0;
    sum += distance(a, b);
    sum += distance(b, c);
    sum += distance(c, a);
    return sum;
}

std::vector<double> find_triangle(std::vector<int> my_vy, int l, int r) {
    if (r - l < 2) {
        return {0,0,0,100000000};
    }
    else {
        int m = (l + r) / 2;
        std::vector<int> vy1;
        std::vector<int> vy2;
        for (int i = 0; i < my_vy.size(); i++) {
            if (vy[my_vy[i]].first == vx[m].first) {
                if (vy[my_vy[i]].second <= vx[m].second) vy1.push_back(my_vy[i]);
                else vy2.push_back(my_vy[i]);
            }
            else {
                if (vy[my_vy[i]].first < vx[m].first) vy1.push_back(my_vy[i]);
                else vy2.push_back(my_vy[i]);
            }
        }
        std::vector<double> LT = find_triangle(vy1, l, m);
        std::vector<double> RT = find_triangle(vy2, m+1, r);
        std::vector<double> res = LT[3] < RT[3] ? LT : RT;
        std::vector<double> close;
        for (int i = 0; i < my_vy.size(); i++) {
            if (abs(vy[my_vy[i]].first - vx[m].first) < res[3]) close.push_back(my_vy[i]);
        }
        std::vector<int> buf;
        int start = 0;
        buf.push_back(close[0]);
        for (int i = 1; i < close.size(); i++) {
            buf.push_back(close[i]);
            for (; start < buf.size(); start++) {
                if (abs(vy[close[start]].second - vy[close[i]].second) - res[3] < 0) break;
            }
            for (int j = start; j < buf.size(); j++) {
                for (int k = j+1; k < buf.size(); k++) {
                    for (int l = k+1; l < buf.size(); l++) {
                        double o = obw(vy[buf[j]], vy[buf[k]], vy[buf[l]]);
                        if (o < res[3]) {
                            res = {(double)buf[j], (double)buf[k], (double)buf[l], o};
                        }
                    }
                }
            }
        }
        return res;
    }
}

int main() {
    int n;
    scanf("%d", &n);
    int x, y;
    for (int i=0; i < n; i++) {
        scanf("%d %d", &x, &y);
        vx.push_back(make_pair(x,y));
        vy.push_back(make_pair(x,y));
    }
    auto start = high_resolution_clock::now();
    sort(vx.begin(), vx.end(), vector_relation_x);
    sort(vy.begin(), vy.end(), vector_relation_y);
    std::vector<int> my_vy;
    for (int i = 0; i < vy.size(); i++) my_vy.push_back(i);
    std::vector<double> res = find_triangle(my_vy, 0, n-1);
    printf("%d %d\n", vy[res[0]].first, vy[res[0]].second);
    printf("%d %d\n", vy[res[1]].first, vy[res[1]].second);
    printf("%d %d\n", vy[res[2]].first, vy[res[2]].second);
    auto stop = high_resolution_clock::now();
    auto duration = duration_cast<milliseconds>(stop - start);

    cout << "Time taken by function: "
         << duration.count() << " microseconds" << endl;
    return 0;
}
