#include "napis.hpp"

#include <iostream>

using namespace std;

ostream& operator << (ostream &wy, const napis &nap) {
    return wy << "\"" << nap.znaki() << "\"";
}

int main() {
    napis n1("Ala"), n2(n1);
    n2.znak(0) = 'E';
    cout << n1 << endl;
    cout << n2 << endl;
    cout << napis(n2).dopisz("&").dopisz(n1) << endl;
    return 0;
}
