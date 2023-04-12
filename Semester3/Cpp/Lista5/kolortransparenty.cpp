#include "kolortransparentny.hpp"
#include <stdexcept>

kolortransparentny::kolortransparentny(double r, double g, double b, double alfa): kolor(r,g,b){
    if ( alfa <0 || alfa>= 256){
        throw std::invalid_argument("Error: alfa ze złego przedziału");
    }
    this->alfa=alfa;
}