matka(bella, kasandra).
matka(bella, aleksander).

ojciec(mortimer, kasandra).
ojciec(mortimer, aleksander).
ojciec(gwidon, mortimer).

rodzic(bella, kasandra).
rodzic(bella, aleksander).
rodzic(mortimer, kasandra).
rodzic(mortimer, aleksander).
rodzic(gwidon, mortimer).

mezczyzna(mortimer).
mezczyzna(aleksander).
mezczyzna(gwidon).

kobieta(bella).
kobieta(kasandra).

jest_matka(X) :-
    matka(X, _).
jest_ojcem(X) :-
    ojciec(X, _).
jest_synem(X) :-
    mezczyzna(X),
    rodzic(_, X).
siostra(X, Y) :-
    kobieta(X),
    rodzic(Z, X),
    rodzic(Z, Y),
    X\=Y.
dziadek(X, Y) :-
    ojciec(X, Z),
    rodzic(Z, Y).
rodzenstwo(X, Y) :-
    rodzic(Z, X),
    rodzic(Z, Y),
    X\=Y.