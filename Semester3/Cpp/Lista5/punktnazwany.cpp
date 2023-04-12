#include "punktnazwany.hpp"
#include <string>
#include <stdexcept>

punktnazwany::punktnazwany(): punktnazwany(""){
}

punktnazwany::punktnazwany(std::string s)
{
    if(s.length()>0){
        if( !isalpha(s[0])){
            throw std::invalid_argument("Error: nazwa powinna zaczynać sie na litere");
        }
        for(char &c : s){
            if(!isalpha(c) and !isdigit(c)){
                throw std::invalid_argument("Error: nazwa powinna zawierac jedynie litery i liczby");
            }
        }

        nazwa=s;

    }
}