#ifndef KOLOR_HPP_INCLUDED
#define KOLOR_HPP_INCLUDED

class kolor
{
protected:
    double r;
    double g;
    double b;
public:
    kolor();
    kolor(double r, double g, double b);
    double get_r();
    double get_g();
    double get_b();
    void set_r(double r);
    void set_g(double g);
    void set_b(double b);
    void change_r(double c);
    void change_g(double c);
    void change_b(double c);
    static kolor get_color( kolor a,  kolor b);
};


#endif //KOLOR_HPP_INCLUDED