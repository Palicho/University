prime(N) :-
    N>=2,
    \+ ( between(2, N, X),
         %X =< N**(1/2),
         N mod X=:=0,
         N=\=X
       ).

prime(LO, HI, N) :-
    between(LO, HI, N),
    prime(N).