//Konrad Oleksy
#include "wielomian.hpp"
#include <iostream>

using namespace std;

int main()
{
    const double wsp[]={2,3,4,5,6};
    cout<<sizeof(wsp)/sizeof(double);
    wielomian w;
    wielomian s;//= wielomian(10);
    s = {3,-2,4};
    w = {-3,-8,0};
    s*=w;
    s= s*w;
    s= s+w;
    s+=w;
    s= s-w;
    s+=w;
    cout<<s;
    return 0;
}

/*
/ the self-pointer concept
//
void* s; // member (first or last) of class-or-struct
s = (void*)&s; // make a self-pointing pointer*/