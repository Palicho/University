#ifndef WEKTOR_CLASS_INCLUDED
#define WEKTOR_CLASS_INCLUDED

#include<stdexcept>

class wektor { 
protected:
    double *tab = nullptr; // macierz liczb zmiennopozycyjnych 
    const int k; // rozmiar tablicy: k pozycji
public:
    //konstruktor tworzacy wektor o k wielkosci( wypełniony 0)
    wektor(int k);

    //konstuktor z listą inizjalizującą 
    wektor(std::initializer_list<double> lst);

    //konstruktor kopiujący
    wektor(const wektor& w);

    //konstruktor przenoszący
    wektor(wektor && w);

    //operator kopiujący
    wektor& operator=(const wektor& w);

    //operator przenoszący
    wektor& operator=(wektor&& w);

    //opertaor indeksowania zwracający wartość
    double operator[](int i ) const;

    double& operator[](int i);
    //operator wejscia strumienia
    friend std::istream& operator>>(std::istream& is, wektor& w);

    //operator wyjscia strumienia
    friend std::ostream& operator<<(std::ostream& os, const wektor&w);


    int size() const{
        return k;
    }
    //destruktor
    ~wektor();
    //...

    friend wektor operator-(const wektor &w); // zmiana znaku 
    friend wektor operator+(const wektor &x, const wektor &y);  
    friend wektor operator-(const wektor &x, const wektor &y);  
    friend wektor operator*(const wektor &w, double d); 
    friend wektor operator*(double d, const wektor &w);
    // iloczyn skalarny x*y 
    friend double operator*(const wektor &x, const wektor &y); 
   
    wektor& operator+=(const wektor &w); 
    wektor& operator-=(const wektor &w); 
    wektor& operator*=(double d); 
};

#endif //WEKTOR_CLASS_INCLUDED