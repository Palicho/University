#ifndef PUNKTKOLOROWY_HPP_INCLUDED
#define PUNKTKOLOROWY_HPP_INCLUDED
 
#include "punkt.hpp"
#include "kolortransparentny.hpp"


class punktkolorowy : public virtual punkt 
{
protected:
    kolortransparentny kolor;
};

#endif //PUNKTKOLOROWY_HPP_INCLUDED