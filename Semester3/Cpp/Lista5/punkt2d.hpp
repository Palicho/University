#ifndef PUNKT2D_HPP_INCLUDED
#define PUNKT2D_HPP_INCLUDED

#include "punkt.hpp"

class punkt2d : public punkt
{
public:
    punkt2d()= default;
    //void transpozycja(const wiektor2d w);

    double get_x();
    double get_y();
};

#endif //PUNKT2D_HPP_INCLUDED