#include "kolejka.hpp"

#include <cstring>
#include <stdexcept>
#include <stdexcept>
#include <iostream>

using namespace std;

kolejka::kolejka() : kolejka(1){
cerr<<"konstruktor delegatowy kolejka() []"<<endl;
}

kolejka::kolejka(const int poj){
    if (poj <=0) throw invalid_argument("niedozwolona wartosc ");
    pojemnosc=poj;
    tab = new string[pojemnosc];
cerr<<"konstruktor kolejka(const int pojemnosc) [" << pojemnosc << "]"<<endl;
}


kolejka::kolejka(initializer_list<string> lst) : kolejka(lst.size()){
    ile=lst.size();
    std::initializer_list<string>::iterator it;
    
    int i=0;

    for ( it=lst.begin(); it!=lst.end(); ++it, ++i) {
        tab[i]=string(*it);
    }
    cerr<<"konstruktor z lista inizjalizujacom"<<endl;   
}

//kopiuujacy
kolejka::kolejka(const kolejka &kol) : pojemnosc(kol.pojemnosc), poczatek(kol.poczatek), ile(kol.ile), tab(new string[pojemnosc]){
    cerr<<"kontrusktor kopiujacy"<<endl;
    for (int i = 0; i < pojemnosc; i++)
    {
        tab[(poczatek + i) % pojemnosc ]=string(kol.tab[(poczatek + i) % pojemnosc]);
    }
}

// przenoszący 
kolejka::kolejka(kolejka &&kol) : pojemnosc(kol.pojemnosc), tab(kol.tab), ile(kol.ile), poczatek(kol.poczatek){
    kol.pojemnosc = kol.poczatek = kol.ile = 0;
    kol.tab = nullptr;
    cerr<<"kontrukor przenoszacy"<<endl;
}

 
const kolejka& kolejka::operator= (const kolejka &kol){
    cerr<<"operator kopiujacy"<<endl;
    if(this != &kol)
    {
        this->~kolejka();
        pojemnosc = kol.pojemnosc;
        poczatek = kol.poczatek;
        ile = kol.ile;
        tab = new string[pojemnosc];
        copy(kol.tab, kol.tab+pojemnosc, tab);
    }
    return *this;
}



const kolejka& kolejka::operator= (kolejka &&kol){
    cerr<<"operator przenoszacy"<<endl;
     if(this != &kol) 
    {
        this->~kolejka();
        pojemnosc = kol.pojemnosc;
        poczatek = kol.poczatek;
        ile = kol.ile;
        tab = kol.tab;

        kol.pojemnosc = kol.poczatek = kol.ile = 0;
        kol.tab = nullptr;
    }
    return *this;
}


kolejka::~kolejka(){
    delete[] tab;
}

void kolejka::wstaw(string napis){
    if( ile >= pojemnosc) throw invalid_argument("kolejka jest juz pelna");
    tab[(poczatek+ile) % pojemnosc ] = string(napis);
    ile++;
 }

string kolejka::usun(){
    if(ile == 0) throw invalid_argument("kolejka jest pusta");
    poczatek= (poczatek+1) % pojemnosc;
    ile--;
    int i = poczatek-1;
    return tab[i];
}

string kolejka::zporzdu(){
    return tab[poczatek];
}

int kolejka::dlugosc(){
    return ile;
}
