#ifndef KOLORNAZWANY_HPP_INCLUDED
#define KOLORNAZWANY_HPP_INCLUDED

#include "kolortransparentny.hpp"
#include <string>

class kolornazwany : kolortransparentny
{
protected:
    std::string nazwa;
public:
    kolornazwany();
    kolornazwany(std::string s);
};

#endif //KOLORNAZWANY_HPP_INCLUDED