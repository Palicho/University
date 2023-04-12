#ifndef NAPIS_HPP_INCLUDED
#define NAPIS_HPP_INCLUDED

#include <string>

class napis {
    int dl;
    char *zn;
public:
    napis();
    napis(const char *n);
    napis(const napis &nap);
    napis(napis &&nap);
    const napis& operator = (const napis &nap);
    const napis& operator = (napis &&nap);
    ~napis();
public:
    int dlugosc() const;
    char znak(int p) const;
    char& znak(int p);
    const char* znaki() const;
    napis& dopisz(const char *n);
    napis& dopisz(const napis &nap);
    napis& dopisz(const std::string &s);
};

napis polacz(const napis &pierwszy, const napis &drugi);

#endif // NAPIS_HPP_INCLUDED


