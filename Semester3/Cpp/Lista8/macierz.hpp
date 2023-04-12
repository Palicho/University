#ifndef MACIERZ_CLASS_INCLUDED
#define MACIERZ_CLASS_INCLUDED

#include "wektor.hpp"
#include "iostream"

class macierz { 

    wektor **tab = nullptr; // macierz wskaźników na wektory 
    const int w, k; // rozmiar tablicy: w wierszy i k kolumn 
    
public:
    macierz(int w, int k);

    //konstruktor kopiujący
    macierz(const macierz& m);
 
    //konstruktor przenoszący
    macierz(macierz&& m);

    //operator kopijący
    macierz& operator=(const macierz& m);

    //operator przenoszący
    macierz& operator=(macierz && m);

    //dekonstruktor
    ~macierz();

    wektor& operator[](int i);
    wektor operator[](int i) const;

    int cols() const;
    int rows() const;

     //operator wejscia strumienia
    friend std::istream& operator>>(std::istream& is, const macierz& m);
    //operator wyjscia strumienia
    friend std::ostream& operator<<(std::ostream& os, const macierz& m);

    friend macierz operator-(const macierz &m); // zmiana znaku  
    friend macierz operator+(const macierz &p, const macierz &q);  
    friend macierz operator-(const macierz &p, const macierz &q);  
    friend macierz operator*(const macierz &m, double d); 
    friend macierz operator*(double d, const macierz &m); 
    friend double operator*(const macierz &p, const macierz &q); 
    friend macierz operator~(const macierz &m); // transpozycja  
    macierz& operator+=(const macierz &m); 
    macierz& operator-=(const macierz &m); 
    macierz& operator*=(double d);

};


#endif //MACIERZ_CLASS_INCLUDED