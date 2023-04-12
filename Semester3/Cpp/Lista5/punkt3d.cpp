#include "punkt3d.hpp"
#include <math.h>
#define __eps 0.0001

bool punkt3d::wspolliniowe(const punkt3d & a, const punkt3d & b, const punkt3d & c){

    return abs((b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x))<__eps && abs((b.z-a.z)*(c.y-a.y)-(b.y-a.y)*(c.z-a.z))<__eps && abs((b.x-a.x)*(c.z-a.z)-(b.z-a.z)*(c.x-a.x))<__eps;

}

double punkt3d::odleglosc(const punkt3d &p)
{  
    return sqrt(pow((p.x-x),2)+pow((p.y-y),2)+pow((p.z-z),2));
}

