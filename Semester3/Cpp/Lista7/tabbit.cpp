#include"tabbit.hpp"
#include<algorithm>
#include<stdexcept>
#include<math.h>


obliczenia::tabbit::tabbit(int rozm): dl(rozm){
    
    if(dl <= 0){
        throw std::invalid_argument("Error: długosc słowa musi być większa niż 0");
    }

    int liczba_slow= std::ceil((double)dl/rozmiarSlowa);

    tab = new slowo[liczba_slow];

    for(int i=0 ; i<liczba_slow ;i++){
        tab[i]=0;
    }
    
}

obliczenia::tabbit::tabbit(slowo tb){

    slowo tmp=tb;
    

    int i= 64;
    while(tmp << 1){
        i--;
    }

    dl=i;
    tab= new slowo[1];
    tab[0]=tb;
}

obliczenia::tabbit::tabbit(std::initializer_list<bool> lst): tabbit((int)lst.size()){
    int i=0;
    for(const bool& b: lst){
        pisz(i,b);
        i++;
    }
}

//konstruktor kopiujący
obliczenia::tabbit::tabbit(const tabbit &tb): tabbit(tb.dl){

    int liczba_slow= std::ceil((double)dl/rozmiarSlowa);

    std::copy(tb.tab,tb.tab+liczba_slow,tab);    
}

//konstruktor przenoszący
obliczenia::tabbit::tabbit(tabbit &&tb) {

    dl=tb.dl;
    tab=tb.tab;

    tb.dl=0;
    tb.tab= nullptr;
}

//operator kopiujący
obliczenia::tabbit& obliczenia::tabbit::operator= (const obliczenia::tabbit &tb){
    if( this != &tb){
        this->~tabbit();

        dl=tb.dl;
        int liczba_slow= std::ceil((double)dl/rozmiarSlowa);
        std::copy(tb.tab,tb.tab+liczba_slow,tab);   
    }

    return *this;
}

//operator przenoszacy
obliczenia::tabbit& obliczenia::tabbit::operator= (obliczenia::tabbit &&tb){

    
    if(this != &tb){
        this->~tabbit();

        dl=tb.dl;
        tab=tb.tab;

        tb.dl=0;
        tb.tab= nullptr;

    }

    return *this;
}

bool obliczenia::tabbit::czytaj(int i) const{
    if(i<0 or i>= dl){
        throw std::out_of_range("Error: poza zakresem");
    }

    int index= i/rozmiarSlowa;
    int shift = i%rozmiarSlowa;

    slowo mask=1;

    return ((tab[index] >> shift ) & mask);
}

bool obliczenia::tabbit::pisz(int i, bool b){

    if(i<0 or i>= dl){
        throw std::out_of_range("Error: poza zakresem");
    }

    int index= i/rozmiarSlowa;
    int shift = i%rozmiarSlowa;

    b = !!b;
    slowo mask =b;
    mask= mask<<shift;

    tab[index]= (tab[index] & ~((slowo)1<< shift)) | mask ;
    // tab[index] &= ~(1ull << shift); // &-against 111[0]1111 // the clear  
    // tab[index] |=  (b << shift);    // |-against 111[b]1111 // the write
    return b;
}

bool obliczenia::tabbit::operator[] (int i) const{
    return czytaj(i);
}

obliczenia::tabbit::ref obliczenia::tabbit::operator[] (int i){
    return tabbit::ref(i, *this);
}

int obliczenia::tabbit::rozmiar() const{
    return dl;
}

//dekonstruktor
obliczenia::tabbit::~tabbit(){
    delete[] tab;
}

//operator przypisanie adresu bitu
bool obliczenia::tabbit::ref::operator=(bool b){
    this->tb.pisz(this->i,b);
    return b;
}

obliczenia::tabbit::ref& obliczenia::tabbit::ref::operator= (const ref &rf){
    bool x=rf.tb[rf.i];
    tb[i]=x;
    return *this;
}


//konstruktor do adresu bitu
obliczenia::tabbit::ref::ref(int i , tabbit& tb): i(i), tb(tb){
}

obliczenia::tabbit& obliczenia::tabbit::operator|= (const tabbit &tb){
    tabbit result= tabbit(min_dl(*this,tb));
    for(int i=0;i<result.rozmiar();i++){
        (*this)[i] = (*this)[i] | tb[i];
    }

    return *this;
}

obliczenia::tabbit& obliczenia::tabbit::operator&= (const tabbit &tb){
    tabbit result= tabbit(min_dl(*this,tb));
    for(int i=0;i<result.rozmiar();i++){
        (*this)[i] = (*this)[i] & tb[i];
    }

    return *this;

}

obliczenia::tabbit& obliczenia::tabbit::operator^= (const tabbit &tb){
    tabbit result= tabbit(min_dl(*this,tb));
    for(int i=0;i<result.rozmiar();i++){
        (*this)[i] = (*this)[i] ^ tb[i];
    }

    return *this;

}
 

namespace obliczenia{

    int min_dl(const tabbit &tb1, const tabbit &tb2){
        if(tb1.rozmiar()<tb2.rozmiar()){
            return tb1.rozmiar();
        }
        else{
            return tb1.rozmiar();
        }
    }

    tabbit operator| (const tabbit &tb1, const tabbit &tb2){

        tabbit result= tabbit(min_dl(tb1,tb2));
        for(int i=0;i<result.rozmiar();i++){
            result[i]=tb1[i] | tb2[i];
        }

        return result;

    }

    tabbit operator& (const tabbit &tb1, const tabbit &tb2){
        
        tabbit result= tabbit(min_dl(tb1,tb2));
        for(int i=0;i<result.rozmiar();i++){
            result[i]=tb1[i] & tb2[i];
        }

        return result;

    }

    tabbit operator^ (const tabbit &tb1, const tabbit &tb2){
        
        tabbit result= tabbit(min_dl(tb1,tb2));
        for(int i=0;i<result.rozmiar();i++){
            result[i]=tb1[i] ^ tb2[i];
        }

        return result;

    }

    tabbit operator! (const tabbit &tb){

        tabbit result= tabbit(tb.dl);

        for(int i=0;i<result.rozmiar();i++){
            result[i]=(tb[i]+1) % 2;
        }

        return result;

    }



    //strumien in tabbit
    std::istream& operator>> (std::istream & we, tabbit &tb){
        bool b;

        for (int i=0; i<tb.dl; i++){
            we>>b;
            tb.pisz(i,b);
        }

        return we;
    }

    //strumien out tabbit
    std::ostream &operator<< (std::ostream & wy, const tabbit &tb){
        wy<<tb.rozmiar()<<"\n";

        for(int i=0;i<tb.rozmiar();i++){
            wy<<tb[i]<<" ";
        }

        wy<<"\n";
        return wy;
    }

    //strumien out ardres bitu
    std::ostream &operator<< (std::ostream & wy, const tabbit::ref &rf){
        wy<<rf.tb.czytaj(rf.i)<<"\n";

        return wy;
    }
}


