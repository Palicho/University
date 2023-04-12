#ifndef PUNKT_HPP_INCLUDED
#define PUNKT_HPP_INCLUDED

class punkt
{
protected:
    double x;
    double y;
public:
    punkt();
    punkt(double x, double y);
    double odleglosc(const punkt& p) const;
    static  bool wspolliniowe(const punkt& a , const punkt& b, const punkt& c );
};


#endif //PUNKT_HPP_INCLUDED