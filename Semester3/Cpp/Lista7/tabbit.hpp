#ifndef TABBIT_CLASS_INCLUDED
#define TABBIT_CLASS_INCLUDED

#include <cstdint>
#include <iostream>

namespace obliczenia{
    class tabbit {
        typedef uint64_t slowo; // komorka w tablicy
        static const int rozmiarSlowa = (int)sizeof(slowo)*8; // rozmiar slowa w bitach
        friend std::istream &operator>> (std::istream & we, tabbit &tb);
        friend std::ostream &operator<< (std::ostream & wy, const tabbit &tb);

        class ref{
            protected:
                int i;
                tabbit & tb;
            public:
                ref(int i , tabbit& tb);
                bool operator=  (bool b);
                //przenoszenie kopiujące
                ref& operator= (const ref &rf);
                operator bool() const{ return tb.czytaj(i);}
                friend std::ostream &operator<< (std::ostream & wy, const ref &rf);

                    
            }; // klasa pomocnicza do adresowania bitów
        friend std::ostream &operator<< (std::ostream & wy, const ref &rf);

    protected:
        int dl; // liczba bitów
        slowo *tab; // tablica bitów
    public:
        // wyzerowana tablica bitow [0...rozm]
        explicit tabbit(int rozm);
        // tablica bitów [0...rozmiarSlowa] zainicjalizowana wzorcem
        explicit tabbit(slowo tb);
        // konstuktor z listą inicjalizacyjną 
        tabbit(std::initializer_list<bool> lst);
    
        // destruktor
        ~tabbit();
        tabbit(const tabbit &tb); // konstruktor kopiujący
        tabbit(tabbit &&tb); // konstruktor przenoszący
        tabbit& operator= (const tabbit &tb); // przypisanie kopiujące
        tabbit& operator= (tabbit &&tb); // przypisanie przenoszące
    private:
        bool czytaj(int i) const; // metoda pomocnicza do odczytu bitu
        bool pisz(int i, bool b); // metoda pomocnicza do zapisu bitu
    public:
        // indeksowanie dla stałych tablic bitowych
        bool operator [] (int i) const;
        // indeksowanie dla zwykłych tablic bitowych
        ref operator [] (int i);
        inline int rozmiar() const; // rozmiar tablicy w bitach
    public:
        friend int min_dl(const tabbit &tb1, const tabbit &tb2);
        friend tabbit operator| (const tabbit &tb1, const tabbit &tb2);
        friend tabbit operator& (const tabbit &tb1, const tabbit &tb2);
        friend tabbit operator^ (const tabbit &tb1, const tabbit &tb2);
        friend tabbit operator! (const tabbit &tb);
        tabbit& operator|=(const tabbit &tb);
        tabbit& operator&=(const tabbit &tb);
        tabbit& operator^=(const tabbit &tb);
    };
}
#endif //TABBIT_CLASS_INCLUDED
