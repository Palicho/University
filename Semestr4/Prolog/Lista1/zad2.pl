on(block1, block0).
on(block2, block1).
on(block3, block2).
on(block4, block3).
on(block5, block4).

above(X, Y) :-
    on(X, Y).
above(X, Y) :-
    on(X, Z),
    above(Z, Y).
