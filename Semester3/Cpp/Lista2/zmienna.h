#ifndef ZMIENNA_H
#define ZMIENNA_H

#include <iostream>
#include <string>

class zmienna{
private:
    std::string nazwa;
    double wartosc;
public:
    zmienna();
    zmienna(std::string nazwa);
    zmienna(std::string nazwa, double wartosc);
    std::string getNazwa();
    double getWartosc();
    void setNazwa(std::string nazwa);
    void setWartosc(double wartosc);
    
};
#endif