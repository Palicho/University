#include <iostream>
#include "zmienna.h"
#include "zbior_zmiennych.h"

using namespace std;

int main(){
    try
    {
        zbior_zmiennych zz= zbior_zmiennych(2);

        zz.insert_zmienna("a", 12.32);
        zz.display();
        
        zmienna  z=zz.get_zmienna("a");
        zz.insert_zmienna("b",231.32);
        zz.display();
        zz.delete_zmienna("b");
        zz.display();
        zz.insert_zmienna("c",3232.23);
        zz.display();
        zz.change_zmienna("c",1.023);
        zz.display();

        zz.change_zmienna("b",1.023);
        zz.display();    
    }
    catch(const std::invalid_argument& e)
    {
        std::cerr << e.what() << '\n';
        return 1;
    }
    
    return 0;
}