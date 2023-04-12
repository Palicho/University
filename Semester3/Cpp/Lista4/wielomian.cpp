//Konrad Oleksy

#include "wielomian.hpp"

#include <iostream>
#include <cstring>
#include <stdexcept>

using namespace std;

//konstruktor jednomianu
wielomian::wielomian(int st, double wsp) : n(st), a(new double[n+1]) {
    if(n<0){
        throw invalid_argument("niepoprawny stopien wielominau");
    }
    a[n]=wsp;
}

//konstruktor wielominau
wielomian::wielomian(int st, const double wsp[]): n(st), a(new double[n+1]){
    if(n<0){
        throw invalid_argument("niepoprawny stopien wielominau");
    }

    for(int i=st;i>=0;i--){
        a[i]=wsp[i-n];
    }
}

//lista współczynnikow
wielomian::wielomian(initializer_list<double> wsp) : n(wsp.size()-1), a(new double[n+1]){
    
    int i = n;
    for( double d : wsp){
        a[i]=d;
        i--;
    }
}

//konstruktor kopiujacy
wielomian::wielomian(const wielomian &w) :n(w.n), a(new double[n+1]){
    copy(w.a,w.a+n+1,a);
}

//konsturktor przenoszacy
wielomian::wielomian(wielomian &&w): n(w.n), a(w.a){
    w.n=0;
    w.a=nullptr;
}

//operator kopiujacy
wielomian& wielomian::operator= (const wielomian &w){
    if(this != &w)
    {   
        this->~wielomian();
        
        n=w.n;
        a= new double[n];
        copy(w.a, w.a+n+1, a);
    }
    return *this;
}

//operator przenoszacy
wielomian& wielomian::operator= (wielomian &&w){
    if( this != &w){

        this->~wielomian();
        n=w.n;
        a=w.a;

        w.n=0;
        w.a=nullptr;
    }
    return *this;
}

//dekonstruktor
wielomian::~wielomian(){
    delete[] a;
}

istream& operator>> (istream &we, wielomian &w){
    int st;
    //cout<<"Podaj stopien wielominau"<<endl;

    we>>st;
    w= wielomian(st);

    for (int i=w.n;i>=0;i--){
        //cout<<"Podaj współczynnik dla a^"+ to_string(i)<<endl;
        we>>w.a[i];
    }

    return we;

}

ostream& operator << (ostream &wy, const wielomian &w)
{

    wy << "stopień: " << w.n << ", współczynniki:";

    for(int i=w.n; i>=0; i--)
    {
        wy << " " << w.a[i];
    }
    wy << '\n';
    return wy;
}

double wielomian::operator[](int i) const{
    if( i>=0 and i<=n){
        return a[i];
    }
    else{
        throw invalid_argument("error in opertaotr[]: argumnet nie należy" 
                                " do dozwolonego przedzniału od 0 do "+ to_string(n));
    }
}

double& wielomian::operator [] (int i){
    if( i>=0 and i<=n){
        return a[i];
    }
    else{
        throw invalid_argument("error in opertaotr[]: argumnet nie należy" 
                               " do dozwolonego przedzniału od 0 do "+ to_string(n));
    }
}

double wielomian::operator() (double x) const{
    double result = a[0];
    for ( int i=1 ; i<=n;i++){
        result = result*x+a[i];
    }
    return result;
} 

wielomian operator * (const wielomian &u, double c){
    wielomian tmp = u;
    tmp *= c;

    return tmp;
}

wielomian& wielomian::operator*= (const wielomian &v){

   wielomian  tmp = *this;
   *this = wielomian(tmp.n+v.n,0.0);

   for (int i=0; i<=tmp.n; i++)
   {
     for (int j=0; j<=v.n; j++)
        this->a[i+j] += tmp.a[i]*v.a[j];
   }

   return *this;
}

wielomian& wielomian::operator+= (const wielomian &v){
    wielomian tmp = *this;
    
    if (tmp.n >= v.n){
        *this=tmp;

        for( int i =0; i<=v.n; i++){
            this->a[i]=tmp.a[i]+v.a[i];
        }
    }
    else{
        *this=v;

        for( int i =0; i<=tmp.n; i++){
            this->a[i]=tmp.a[i]+v.a[i];
        }
    }

    this->correct_st();
    return *this;
}

wielomian& wielomian::operator-= (const wielomian &v){
    wielomian tmp= *this;
    if (tmp.n >= v.n){
        *this=tmp;

        for( int i =0; i<=v.n; i++){
            this->a[i]=tmp.a[i]-v.a[i];
    }
    }
    else{
        *this=wielomian(v.n,0.0);
        for(int i = v.n; i>tmp.n;i--){
            this->a[i]=0-v.a[i];
        }
        for(int i = tmp.n;i>=0;i--){
            this->a[i]=tmp.a[i]-v.a[i];
        }
    }

    this->correct_st();
    return *this;
}

wielomian& wielomian::operator *= (double c){
    for (int i = 0; i <= n; i++){
        a[i] *= c;
    }

    this->correct_st();
    return *this;
}

wielomian operator*(const wielomian &u, const wielomian &v){
    wielomian tmp = u;
    tmp *= v;

    return tmp;
}
 
wielomian operator+(const wielomian &u, const wielomian &v){
    wielomian tmp;
    if (u.n >= v.n){
        tmp=u;

        for( int i =0; i<=v.n; i++){
            tmp.a[i]=u.a[i]+v.a[i];
        }
    }
    else{
        tmp=v;

        for( int i =0; i<=u.n; i++){
            tmp.a[i]=u.a[i]+v.a[i];
        }
    }

    tmp.correct_st();    
    return tmp;
}

wielomian operator-(const wielomian &u, const wielomian &v){
    
    return u + v * -1;
}

int wielomian::get_st(){
    return n;
}

void wielomian::correct_st(){
    int i=n;
    while(a[i] == 0){
        i--;
    }

    if( i<n){
        double * d=new double;
        copy(a,a+i+1,d);
        n=i;
        delete [] a;
        a=d;
    }
}