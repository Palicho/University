#include "wektor.hpp"
#include "iostream"

//konstruktor tworzacy wektor o k wielkosci( wypełniony 0.0)
wektor::wektor(int k): k(k){
    if(k<=0){
        throw std::invalid_argument("Error: niedozwolona dlugosc wektora");
    }

    tab= new double[k];

    for(int i=0;i<k; i++){
        tab[i]=0.0;
    }
}

//konstuktor z listą inizjalizującą 
wektor::wektor(std::initializer_list<double> lst): k(lst.size()){
    tab = new double[k];

    int i=0;
    for(auto const& d : lst)
    {
        tab[i]=d;
        i++;
    }
}

//konstruktor kopiujący
wektor::wektor(const wektor& w): k(w.k){
    if(w.k!=k){
        throw std::invalid_argument("Error: niedozwolona długość wektora do sk");
    }

    tab = new double[k];
    std::copy(w.tab, w.tab+w.k, tab);
}

//konstruktor przenoszący
wektor::wektor(wektor && w): k(w.k){

    tab=w.tab;
    w.tab=nullptr;
}

//operator kopiujący
wektor& wektor::operator=(const wektor& w){
    if( this != &w){
        
        if(k != w.k){
            throw std::invalid_argument("Error: sfddfs wekktory powinny być tej samej długości");
        }

        std::copy(w.tab, w.tab+w.k, tab);

    }

    return *this;
}

//operator przenoszący
wektor& wektor::operator=(wektor&& w){
      if( this != &w){
        
        if(k != w.k){
            throw std::invalid_argument("Error: prznoszący  wektory powinny być tej samej długości");
        }

        tab=w.tab;

        w.tab=nullptr;

    }

    return *this;
}


//opertaor indeksowania zwracający wartość
double wektor::operator[](int i ) const{
    if(i<0 or i>=k){
        throw std::out_of_range("Error: nie ma takie indeksu");
    }

    return tab[i];
}

double& wektor::operator[](int i){
    if(i<0 or i>=k){
        throw std::out_of_range("Error: nie ma takie indeksu");
    }
    return tab[i];
}


std::istream& operator>>(std::istream& is, wektor& w){

    for(int i=0; i<w.k;i++){
        is>>w[i];
    }

    return is;
}


std::ostream& operator<<(std::ostream& os,const wektor& w) {
    for(int i=0; i<w.size(); i++){
        os<<w[i]<<" ";
    }
    return os;
}

wektor operator-(const wektor &w){
    for(int i=0; i<w.k; i++){
        w.tab[i]=-w.tab[i];
    }
}

wektor operator+(const wektor &x, const wektor &y){
    if(x.k != y.k){
        throw std::invalid_argument("Error: ");
    }       
    
    wektor tmp(x.k);

    for(int i=0; i<x.k; i++){
        tmp[i]=x[i]+y[i];
    }

    return tmp;
}


wektor operator-(const wektor &x, const wektor &y){
    if(x.k != y.k){
        throw std::invalid_argument("Error: ");
    }   
    
    wektor tmp(x.k);

    for(int i=0; i<x.k; i++){
        tmp[i]=x[i]-y[i];
    }


    return tmp;
}

wektor operator*(const wektor &w, double d){
    
    wektor tmp(w.k);

    for(int i =0 ; i<tmp.k;i++){
        tmp[i]=d*w[i];
    }

    return tmp;
}

wektor operator*(double d, const wektor &w){
    wektor tmp(w.k);

    return tmp*d;

}

double operator*(const wektor &x, const wektor& y){

    if(x.k != y.k){
        throw std::invalid_argument("Error: ");
    }
    double result=0;
    for(int i=0; i<x.k;i++){
        result+=x[i]*y[i];
    }

    return result;
}




wektor& wektor::operator+=(const wektor &w){

    if(k != w.size()){
        throw std::invalid_argument("Error: ");
    }

    *this = *this + w;

    return *this;
} 

wektor& wektor::operator-=(const wektor &w){
    
    if(k != w.size()){
        throw std::invalid_argument("Error: ");
    }

    *this = *this - w;

    return *this;
}

wektor& wektor::operator*=(double d){

    *this = *this * d;

    return *this;
}
    
//destruktor
wektor::~wektor(){
    delete [] tab;
}

