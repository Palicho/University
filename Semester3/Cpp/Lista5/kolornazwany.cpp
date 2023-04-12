#include "kolornazwany.hpp"
#include <stdexcept>

kolornazwany::kolornazwany(){
    nazwa="";
}

kolornazwany::kolornazwany(std::string s){
    for( char &c : s){
        if(!isalpha(c)){
            throw std::invalid_argument("nazwa musi się składać tylko z liter");
        }
    }
    nazwa=s;
}