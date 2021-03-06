directly_left_of(pencil, hourglass).
directly_left_of(hourglass, butterfly).
directly_left_of(butterfly, fish).
left_of(bike, camera).

left_of(X, Y) :-
    directly_left_of(X, Y).
left_of(X, Y) :-
    directly_left_of(X, Z),
    left_of(Z, Y).

directly_above(bike, pencil).
directly_above(camera, butterfly).

above(X, Y) :-
    directly_above(X, Y).
above(X, Y) :-
    directly_above(X, Z),
    above(Z, Y).

right_of(X, Y) :-
    left_of(Y, X).

below(X, Y) :-
    above(Y, X).

higher(X, Y) :-
    (   above(X, Y)
    ;   (   left_of(A, Y)
        ;   right_of(A, Y)
        ),
        above(X, A)
    ).