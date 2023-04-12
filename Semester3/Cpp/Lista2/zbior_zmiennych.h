#ifndef ZBIOR_ZMIENNYCH_H
#define ZBIOR_ZMIENNYCH_H

#include "zmienna.h"

class zbior_zmiennych
{
private:
    const int n;
    zmienna *tab;
    int k;
public:
    zbior_zmiennych(int n);
    ~zbior_zmiennych();
    bool insert_zmienna(std::string nazwa, double wartosc);
    bool delete_zmienna(std::string nazwa);
    bool change_zmienna(std::string nazwa, double wartosc);
    zmienna  get_zmienna(std::string nazwa);
    void display();
};

#endif