#include <bits/stdc++.h>
using namespace std;

#define MX 62
vector<long double> floyd[MX];

long double distance(long double x1, long double y1, long double z1, long double x2, long double y2, long double z2) {
    long double xs = (x1 - x2) * (x1 - x2);
    long double ys = (y1 - y2) * (y1 - y2);
    long double zs = (z1 - z2) * (z1 - z2);
    //cout << "distance " << sqrt(xs + ys + zs) << "\n";
    return sqrt(xs+ys+zs);
}

void warshall(const vector<long double> e[], int n) {
    for (int i = 0; i < n; i++) {
        floyd[i] = e[i];
    }
    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                //cout << floyd[i][k] << " " << floyd[k][j] <<" "<< floyd[i][j] << "\n";
                if (floyd[i][k] + floyd[k][j] < floyd[i][j]) {
                  //cout << "Here\n";
                  floyd[i][j] = floyd[i][k] + floyd[k][j];
                }
            }
        }
    }
}

int main () {
    int n;
    cin >> n;
    for (int i = 0; i < n; i++) {
        cout << "Case " << i+1 << " :\n";
        int planet, wormhole, queries;
        cin>>planet;
        map<string, int> planets;
        vector<long double> pl[planet];
        for (int j = 0; j < planet; j++) {
            string name;
            long double x, y, z;
            cin >> name;
            cin >> x >> y >> z;
            planets[name] = j;
            pl[j].push_back(x);
            pl[j].push_back(y);
            pl[j].push_back(z);
        }
        cin >> wormhole;
        vector<long double> edges[planet];
        for (int j = 0; j < planet; j++) {
            for (int k = 0; k < planet; k++) {
                edges[j].push_back(distance(pl[j][0], pl[j][1], pl[j][2], pl[k][0], pl[k][1], pl[k][2]));
            }
        }
        for (int j = 0; j < wormhole; j++) {
            string start, end;
            cin >> start >> end;
            int str_id, end_id;
            str_id = planets[start];
            end_id = planets[end];
            edges[str_id][end_id] = 0;
        }
        warshall(edges, planet);
        //cout << "TESTSTSTTS " << floyd[0][1]<<"\n";
        cin >> queries;
        for (int j = 0; j < queries; j++) {
            string start, end;
            cin >> start >> end;
            int str_id, end_id;
            str_id = planets[start];
            end_id = planets[end];
            //cout << start.c_str() << " " << end.c_str() << " " << str_id << " " << end_id << " " << floyd[str_id][end_id] << "\n";
            cout << "The distance from " << start << " to " << end << " is " << fixed << setprecision(0) << floyd[str_id][end_id] << " parsecs.\n";
        }
    }
}
