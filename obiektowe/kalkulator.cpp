#include <iostream>
using namespace std;

int main () {
    cout<<"1-dodawanie 2-odejmowanie 3-mnozenie 4-dzielenie" <<endl<<"Podaj numer dzialania:"<<endl;
    int dzialanie, a, b;
    cin>>dzialanie;
    if (dzialanie==1) {
        cout<<"podaj liczby" <<endl;
        cin>>a>>b;
        cout<< a + b;
    }  
    else if (dzialanie==2) {
        cout<<"podaj liczby" <<endl;
        cin>>a>>b;
        cout<< a - b;
    }
    else if (dzialanie==3) {
        cout<<"podaj liczby" <<endl;
        cin>>a>>b;
        cout<< a * b;
    }
    else {
        cout<<"podaj liczby" <<endl;
        cin>>a>>b;
        if (b==0) {
            cout<<"ERROR";
        }
        else {
            cout<< a / b;
        }
    }
    cout<<endl;
    return 0;
}
