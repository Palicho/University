#ifndef PUNKTKOLORNAZWANY_HPP_INCLUDED
#define PUNKTKOLORNAZWANY_HPP_INCLUDED

#include "punktkolorowy.hpp"
#include "punktnazwany.hpp" 

class punktkolorowynazwany : public virtual punktkolorowy , public virtual punktnazwany
{
public:
    punktkolorowynazwany(double x, double y, std::string nazwa, kolortransparentny kolor);
};

#endif //PUNKTKOLORNAZWANY_HPP_INCLUDED