#include "macierz.hpp"

macierz::macierz(int w, int k): w(w), k(k){
    
    if(w <= 0 or k <= 0){
        throw std::invalid_argument("Error: liczba kolumn i wierszy powinna być dodatnia");
    }

    tab= new wektor*[w];

    for(int i=0; i<w;i++){
        tab[i]= new wektor(k);
    }
}

//konstruktor kopijący
macierz::macierz(const macierz& m): w(m.w), k(m.k){
    tab= new wektor*[w];

    for(int i=0; i<w;i++){
        tab[i]= new wektor(k);
    }
}

//konstruktor przenoszący
macierz::macierz(macierz&& m): w(m.w), k(m.k){
    tab=m.tab;

    m.tab= nullptr;
}

//operator kopijący
macierz& macierz::operator=(const macierz& m ){
    if(this != &m){
        if(k != m.k or w != m.w){
            throw std::invalid_argument("Error: nie można przypisać macierzy o różnych rozmiarach");
        }
        for(int i=0; i<w;i++){
            std::copy(m.tab[i], m.tab[i]+m.k, tab[i]);
        }
    }

    return *this;
}

macierz& macierz::operator=(macierz&& m){

    if(this != &m){
          if(k != m.k or w != m.w){
            throw std::invalid_argument("Error: nie można przypisać macierzy o różnych rozmiarach");
        }

        tab=m.tab;

        m.tab=nullptr;

    }

    return *this;
}

wektor& macierz::operator[](int i){
    if(i <0 or i>=w){
        throw std::invalid_argument("Error: nieprawidłowy indeks kolmuny");
    }

    return *tab[i];
}

wektor macierz::operator[](int i) const {
    if(i <0 or i>=w){
        throw std::invalid_argument("Error: nieprawidłowy indeks kolmuny");
    }

    return wektor(*tab[i]);
}

macierz::~macierz(){
    for(int i=0; i<w;i++){
        delete tab[i];

    }

    delete [] tab;
}

int macierz::cols()const{
    return k;
}

int macierz::rows()const{
    return w;
}

std::istream& operator>>(std::istream& is, macierz& m){
    
    if(&m == nullptr){
        throw std::invalid_argument("Error: to zmien!");
    }

    for(int i=0; i<m.rows();i++){
        for(int j=0; j<m.cols();j++){
            is>>m[i][j];
        }
    }
    return is;
}


std::ostream& operator<<(std::ostream& os,const macierz& m) {

    for(int i=0; i<m.rows();i++){
        for(int j=0; j<m.cols();j++){
            os<<m[i][j]<<" ";

        }
        os<<"\n";
    }

    return os;
}

macierz operator-(const macierz &m){
    macierz tmp(m.rows() ,m.cols());

    for(int i=0;i<tmp.rows();i++){
        tmp[i]=-m[i];
        
    }
    return tmp;
}

macierz operator+(const macierz &p, const macierz &q){

    if(p.cols() != q.cols() or p.rows() != q.rows()){
        throw std::invalid_argument("Error: Zmień to!");
    }

    macierz tmp(p.rows() ,p.cols());

    for(int i=0; i<tmp.rows();i++){
        tmp[i]= p[i] + q[i];
        
    }

    return tmp;
}

macierz operator-(const macierz &p, const macierz &q){

    if(p.cols() != q.cols() or p.rows() != q.rows()){
        throw std::invalid_argument("Error: Zmień to!");
    }
    
    macierz tmp(p.rows() ,q.cols());


    for(int i=0; i<tmp.rows();i++){
        tmp[i]= p[i] - q[i];
        
    }
    
    return tmp;
}

macierz operator*(const macierz &m, double d){
    
    macierz tmp(m.rows() ,m.cols() );


    for(int i=0; i<tmp.rows();i++){
        for(int j=0; j<tmp.cols();j++){
            tmp[i]= m[i] * d;
        }
    }
    
    return tmp;
}

macierz operator*(double d, const macierz &m){
    
    macierz tmp(m.rows() ,m.cols());    
    return tmp*d;
}

// double operator*(const macierz &p, const macierz &q){
//     double result=0;

// }

macierz operator~(const macierz &m){

    macierz tmp( m.cols(), m.rows());

    for(int i=0; i<m.rows();i++){
        for(int j=0; j<m.cols();j++){
            tmp[i][j]=m[j][i];
        }
    }

    return tmp;
}

// macierz& macierz::operator+=(const macierz &m){
    
//     return this + m;
// } 
// macierz& macierz::operator-=(const macierz &m){

//     if(k != m.cols() or w != m.rows()){
//         throw std::invalid_argument("Error: Zmień to!");
//     }

//     return this-=m;
// }

// macierz& macierz::operator*=(double d){

//     return this * d;
// }






