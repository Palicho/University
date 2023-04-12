#ifndef KOLEJKA_HPP_INCLUDED
#define KOLEJKA_HPP_INCLUDED

#include <string>

using namespace std;

class kolejka{
    int pojemnosc, poczatek =0, ile =0;
    string *tab;
public:
    kolejka();
    kolejka(int poj);
    kolejka(initializer_list<string> lst);
    kolejka(const kolejka &kol);
    kolejka(kolejka &&kol);
    const kolejka& operator = (const kolejka &kol);
    const kolejka& operator = (kolejka &&kol);
    ~kolejka();
public:
    void wstaw(string napis);
    string usun();
    string zporzdu();
    int dlugosc();

};

#endif // KOLEJKA_HPP_INCLUDED