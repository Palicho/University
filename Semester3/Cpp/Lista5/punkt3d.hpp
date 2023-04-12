#ifndef  PUNKT3D_HPP_INCLUDED
#define PUNKT3D_HPP_INCLUDED

#include "punkt2d.hpp"

class punkt3d :  public punkt2d
{
protected:
    double z;
public:
    //void transpozycja(const wektor3d& w);
    double odleglosc(const punkt3d & p);
    static bool wspolliniowe(const punkt3d & a, const punkt3d & b,const punkt3d & c);
};



#endif //PUNKT3D_HPP_INCLUDED