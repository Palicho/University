//Konrad Oleksy

#ifndef WIELOMIAN_HPP_INCLUDED
#define WIELOMIAN_HPP_INCLUDED

#include <initializer_list>
#include <iostream>
using namespace std;


class wielomian{

private:
    int n;
    double *a;

public:
    wielomian( int st=0, double wsp=1.0);//konstuktor jednomianu
    wielomian(int st, const double wsp[]); // konstruktor wielomianu 
    wielomian(initializer_list<double> wsp); // lista współczynników 
    wielomian(const wielomian &w); // konstruktor kopiujący 
    wielomian(wielomian &&w); // konstruktor przenoszący 
    wielomian& operator = (const wielomian &w); // przypisanie kopiujące 
    wielomian& operator = (wielomian &&w); // przypisanie przenoszące 
    ~wielomian (); // destruktor
    
public:
    friend istream& operator >> (istream &we, wielomian &w); 
    friend ostream& operator << (ostream &wy, const wielomian &w);

public: 
    friend wielomian operator + (const wielomian &u, const wielomian &v); 
    friend wielomian operator - (const wielomian &u, const wielomian &v); 
    friend wielomian operator * (const wielomian &u, const wielomian &v); 
    friend wielomian operator * (const wielomian &u, double c); 
    wielomian& operator += (const wielomian &v); 
    wielomian& operator -= (const wielomian &v); 
    wielomian& operator *= (const wielomian &v); 
    wielomian& operator *= (double c); 
    double operator () (double x) const; // wartość wielomianu dla x 
    double operator [] (int i) const; // do odczytu współczynnika 
    double& operator [] (int i); // do zapisu współczynnika 
public:
    int get_st();
    void correct_st();
};

#endif //WIELOMIAN_HPP_INCLUDED