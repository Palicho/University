#include "punkt.hpp"
#include <math.h>

#define __eps 0.001 /* the epsilon */

punkt::punkt() : punkt(0,0){}

punkt::punkt(double x, double y): x(x), y(y){}

double punkt::odleglosc(const punkt& p) const{
    return sqrt(pow((x-p.x),2)+pow((y-p.y),2));
}

bool punkt::wspolliniowe(const punkt& a , const punkt& b, const punkt& c ) {
    return abs((b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x))<__eps;

}
