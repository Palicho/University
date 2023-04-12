#include "kolejka.hpp"
#include <iostream>

int main(int argc, char const *argv[])
{
    kolejka kol={"raz", "dwa","trzy"};
    cout<<kol.zporzdu()<<endl;
    cout<<kol.usun()<<" "<<kol.dlugosc()<<endl;
    cout<<kol.zporzdu()<<endl;

    kol.wstaw("cztery");
    // kol.wstaw("piec");
    
    //copy
    kolejka pal(20);
    pal.wstaw("inny");
    //pal = kol;
    //swap
    swap(kol,pal);
    
    cout<<kol.dlugosc()<< " "<<pal.dlugosc()<<endl;

    return 0;
}
