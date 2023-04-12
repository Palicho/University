#include"tabbit.hpp"
#include<iostream>

using namespace std;
using namespace obliczenia;


int main(){
    
    tabbit z{1,1,0,1,0};
    tabbit t(65);
    // cin>>t;
    // cout<<t;

    cout<<t<<endl;
    cout<<z<<endl;
    cout<<(z & t)<<endl;
    cout<<(z | t)<<endl;
    cout<<(z ^ t)<<endl;
    cout<<(!z)<<endl;
    cout<<(z &= t)<<endl;
    cout<<(z |= t)<<endl;
    cout<<(z ^= t)<<endl;
    
    //tabbit t(65); // tablica 46-bitowa (zainicjalizowana zerami) 
    tabbit u(64); // tablica 64-bitowa (sizeof(uint64_t)*8) 
    tabbit v(t); // tablica 46-bitowa (skopiowana z t) 
    tabbit w(tabbit{1, 0, 1, 1, 0, 0, 0, 1}); // tablica 8-bitowa 
    v[0] = 1; // ustawienie bitu 0-go bitu na 1 
    t[32] = 1; // ustawienie bitu 45-go bitu na 1 
    bool b = v[1]; // odczytanie bitu 1-go
    cout<<"wartosc B: "<<b<<endl; // powinno być 
    u[45] = u[46] = u[63]; // przepisanie bitu 63-go do 45-go i 46-go
    cout<<w<<endl; // wyświetlenie zawartości tablicy bitów na ekranie
    w[0]=w[1];
    cout<<w<<endl; // wyświetlenie zawartości tablicy bitów na ekranie
    cout<<t<<endl;
    return 0;
}