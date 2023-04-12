#ifndef  PUNKTNAZWANY_HPP_INCLUDED
#define PUNKTNAZWANY_HPP_INCLUDED

#include <string>
#include "punkt.hpp"

class punktnazwany : public virtual punkt
{
protected:
    std::string nazwa;
public:
    punktnazwany();
    punktnazwany(std::string s);
};


#endif //PUNKTNAZWANY_HPP_INCLUEDED