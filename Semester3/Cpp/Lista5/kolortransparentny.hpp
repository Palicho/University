#ifndef KOLORTRANSPARENTNY_HPP_INCLUDED
#define KOLORTRANSPARENTNY_HPP_INCLUDED

#include "kolor.hpp"

class kolortransparentny : kolor
{
protected:
    int alfa;
public:
    kolortransparentny()=default;
    kolortransparentny(double r, double g, double b, double alfa);
};

#endif //KOLORTRANSPARENTNY_HPP_INCLUDED