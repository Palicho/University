#include "punktkolorowynazwany.hpp"

punktkolorowynazwany::punktkolorowynazwany(double x, double y, std::string nazwa, kolortransparentny kolor): punkt(x,y){
    this->kolor=kolor;
    this->nazwa=nazwa;
}
