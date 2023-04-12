#include "napis.hpp"

#include <cstring>

#include <stdexcept>
#include <iostream>

using namespace std;

napis::napis() : napis("") {
cerr << "konstruktor delegatowy napis() []" << endl;
}

napis::napis(const char *n) {
    if (not n) throw invalid_argument("pusty wskaznik do ciagu znakow");
    dl = strlen(n);
    zn = new char[dl + 1];
    strcpy(zn, n);
cerr << "konstruktor napis(const char *n) [" << zn << "]" << endl;
}

napis::napis(const napis &nap) : dl(nap.dl), zn(new char[dl + 1]) {
    strcpy(zn, nap.zn);
cerr << "konstruktor kopiujacy napis(const napis &nap) [" << zn << "]" << endl;
}

napis::napis(napis &&nap) : dl(0), zn(nullptr) {
    swap(dl, nap.dl);
    swap(zn, nap.zn);
cerr << "konstruktor przenoszacy napis(napis &&nap) [" << zn << "]" << endl;
}

const napis& napis::operator = (const napis &nap) {
    if (this == &nap) return *this;
    this->~napis();
    dl = nap.dl;
    zn = new char[dl + 1];
    strcpy(zn, nap.zn);
    return *this;
cerr << "przypisanie kopiujace operator=(const napis &nap) [" << zn << "]" << endl;
}


const napis& napis::operator = (napis &&nap) {
    if (this == &nap) return *this;
    swap(dl, nap.dl);
    swap(zn, nap.zn);
    return *this;
cerr << "przypisanie przenoszace operator=( napis &&nap) [" << zn << "]" << endl;
}

napis::~napis() {
cerr << "desrtuktor ~napis() [" << zn << "]" << endl;
    delete[] zn;
}

int napis::dlugosc() const {
    return dl;
}

char napis::znak(int p) const {
    if (p < 0 || p > dl) throw invalid_argument("pozycja spoza zakresu napisu");
    return zn[p];
}
char& napis::znak(int p) {
    if (p < 0 || p >= dl) throw invalid_argument("pozycja spoza zakresu napisu");
    return zn[p];
}
const char* napis::znaki() const {
    return zn;
}
napis& napis::dopisz(const char *n) {
    if (not n) return *this;
    int d = strlen(n);
    if (not d) return *this;
    char *z = new char[dl + d + 1];
    strcpy(z, zn), strcpy(z + dl, n);
    delete[] zn;
    dl += d;
    zn = z;
    return *this;
}
napis& napis::dopisz(const napis &nap) {
    return this->dopisz(nap.znaki());
}
napis& napis::dopisz(const string &s) {
    return this->dopisz(s.c_str());
}

napis polacz(const napis &pierwszy, const napis &drugi) {
    return napis(pierwszy).dopisz(drugi.znaki());
}
