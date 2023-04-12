#include "kolor.hpp"
#include <stdexcept>
#include <string>

kolor::kolor() : r(255), g(255), b(255){}

kolor::kolor(double r, double g, double b) {
    if( r<0 or r>=256 or g<0 or g>=256 or b<0 or b>=256 ){
        throw std::invalid_argument("Error: przynajmniej jeden arguemnt nie mieści się w zakresie (0, 256)");
    }
    this->r=r;
    this->g=g;
    this->b=b;
}

double kolor::get_r(){
    return r;
}

double kolor::get_g(){
    return g;
}

double kolor::get_b(){
    return b;
}

void kolor::set_r(double r){
    if(r < 0 or r >= 256){
        throw  std::invalid_argument("Error: podany argument nie miesci się w zakranie (0, 256)");
    }
    this->r=r; 

}

void kolor::set_g(double g){
    if(g < 0 or  g >= 256){
        throw  std::invalid_argument("Error: podany argument nie miesci się w zakranie (0, 256)");
    }
    this->g=g; 

}

void kolor::set_b(double c){
    if(b < 0 or b >= 256){
        throw  std::invalid_argument("Error: podany argument nie miesci się w zakranie (0, 256)");
    }
    this->b=b; 

}

void kolor::change_r(double c){
    if(r+c < 0 or r+c >= 256){
        throw  std::invalid_argument("Error: po zmianie o " + std::to_string(c) + " podany argument nie miesci się w zakranie (0, 256)");
    }
    this->r+=c; 

}

void kolor::change_g(double c){
    if(g+c < 0 or  g+c >= 256){
        throw  std::invalid_argument("Error: po zmianie o " + std::to_string(c) + " podany argument nie miesci się w zakranie (0, 256)");
    }
    this->g+=c; 

}

void kolor::change_b(double c){
    if(b+c < 0 or b+c >= 256){
        throw  std::invalid_argument("Error: po zmianie o " + std::to_string(c) + " podany argument nie miesci się w zakranie (0, 256)");
    }
    this->b+=c; 

}

kolor kolor::get_color( kolor k1,  kolor k2){
    double r,g,b;
    r=(k1.get_r()+k2.get_r())/2;
    g=(k1.get_g()+k2.get_g())/2;
    b=(k1.get_b()+k2.get_b())/2;

    return kolor(r,g,b);
}
