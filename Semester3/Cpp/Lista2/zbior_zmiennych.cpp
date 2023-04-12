#include "zbior_zmiennych.h"

zbior_zmiennych::zbior_zmiennych(int size) : n(size)
{   
    this->tab = NULL;
    if(n<0){
        throw std::invalid_argument("zly argument");
    }
    this->tab = new zmienna[n];
    k=0;
};

zbior_zmiennych::~zbior_zmiennych()
{
    delete [] this->tab;
};

bool zbior_zmiennych::insert_zmienna(std::string nazwa, double wartosc){

    if(k == n){
        std::cout<<"nie dodano zmiennej: brak miejsca w tablicy"<<std::endl;
        return 1;
    }

    for(int i=0;i<k;i++){
        if(tab[i].getNazwa() == nazwa){
            std::cout<<"nie dodano zmiennej: zmienna o takiej nazwie już istnie"<<std::endl;
            return 1;
        }
    }
    tab[k]= zmienna(nazwa, wartosc);
    k++;
    
    std::cout<<"dodano zmienną"<<std::endl;

    return 0;
};

bool zbior_zmiennych::delete_zmienna(std::string nazwa){
   for(int i=0;i<k;i++){
        if(tab[i].getNazwa() == nazwa){
            tab[i] = tab[k-1];
            k--;

            std::cout<<"usunieto zmienna"<<std::endl;

            return 0;
        }
    }
    std::cout<<"nie usunieto zmiennej: zmienna o takiej nazwie nie istnieje"<<std::endl;
    return 1;
};

bool zbior_zmiennych::change_zmienna(std::string nazwa, double wartosc){
    for(int i=0;i<k;i++){
        if(tab[i].getNazwa() == nazwa){
            tab[i].setWartosc(wartosc);
            return 0;
        }
    }

    std::cout<<"nie zmieniono zmiennej: zmienna o takiej nazwie nie istnieje"<<std::endl;
    return 0;
};

zmienna zbior_zmiennych::get_zmienna(std::string nazwa){
    for(int i=0;i<k;i++){
        if(tab[i].getNazwa() == nazwa){
            return tab[i];
        }
    }
    throw std::invalid_argument("zly argument");
};

void zbior_zmiennych::display(){
     for(int i=0;i<k;i++){
         std::cout<<i<<" "<<tab[i].getNazwa()<<" "<<tab[i].getWartosc()<<std::endl;
    }
    std::cout<<std::endl;
}