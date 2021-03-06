/*
le(1, 1).
le(1, 2).
le(1, 3).
le(2, 2).
le(2, 3).
le(3, 3).
%le(3, 2).
*/

le(1,1).
le(1,2).
le(1,3).
le(1,4).
le(1,5).
le(1,6).

le(2,2).
le(2,3).
le(2,4).
le(2,5).
le(2,6).

le(3,3).
le(3,4).
le(3,5).
le(3,6).
le(3,7).

le(4,4).
le(4,7).

le(5,5).
le(5,6).
le(5,7).

le(6,6).
le(6,7).

le(7,7).

% ∀x xeD => x~x
zwrotna :-
    \+ ( (   le(X, _)
         ;   le(_, X)
         ),
         \+ le(X, X)
       ).

% ∀x,y,z x~y & y~z => x~z
przechodnia :-
    \+ ( le(X, Y),
         le(Y, Z),
         \+ le(X, Z)
       ).

% ∀x,y x~y & y~x => x=y
antysymetryczna :-
    \+ ( le(X, Y),
         le(Y, X),
         X\=Y
       ).

czesciowy_porzadek :-
    zwrotna,
    przechodnia,
    antysymetryczna.
