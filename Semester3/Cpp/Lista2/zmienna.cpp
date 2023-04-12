#include "zmienna.h"

/*konstruktory*/
zmienna::zmienna(){
    this->nazwa='_';
};

zmienna::zmienna(std::string nazwa){
    this->nazwa=nazwa;
};

zmienna::zmienna(std::string nazwa, double wartosc){
    this->nazwa=nazwa;
    this->wartosc=wartosc;
};

/*funkcje składowe*/

//inline?
std::string zmienna::getNazwa(){
    return this->nazwa;
};

//inline?
double zmienna::getWartosc(){
    return this->wartosc;
};

void zmienna::setNazwa(std::string nazwa){
    this->nazwa=nazwa;
};

void zmienna::setWartosc(double wartosc){
    this->wartosc=wartosc;
};