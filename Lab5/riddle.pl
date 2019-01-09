
change(s,e).
change(e,s).

% No more than 2 people on bridge
move([A, A, X, Y, s], [a,b], [B, B, X, Y, e]) :- change(A, B).
move([A, X, A, Y, s], [a,c], [B, X, B, Y, e]) :- change(A, B).
move([A, X, Y, A, s], [a,d], [B, X, Y, B, e]) :- change(A, B).
move([X, A, A, Y, s], [b,c], [X, B, B, Y, e]) :- change(A, B).
move([X, A, Y, A, s], [b,d], [X, B, Y, B, e]) :- change(A, B).
move([X, Y, A, A, s], [c,d], [X, Y, B, B, e]) :- change(A, B).

% Torch must be returned after each trip
move([A, X, Y, Z, e], [ a ], [B, X, Y, Z, s]) :- change(A, B).
move([X, A, Y, Z, e], [ b ], [X, B, Y, Z, s]) :- change(A, B).
move([X, Y, A, Z, e], [ c ], [X, Y, B, Z, s]) :- change(A, B).
move([X, Y, Z, A, e], [ d ], [X, Y, Z, B, s]) :- change(A, B).


timeOf([a], 1):-!.
timeOf([b], 2):-!.
timeOf([c], 5):-!.
timeOf([d], 10):-!.


timeOf([_,X],T) :- timeOf([X],T).


solution([e,e,e,e,e], [], _).
solution(C,[Move | Next], T):- move(C, Move, C2), timeOf(Move, X), T1 is T - X, T1 >= 0, solution(C2, Next, T1).


run(X,T) :- solution([s,s,s,s,s], X, T).
run(X) :- num(T), solution([s,s,s,s,s], X, T).

num(1).
num(X) :- num(Y), X is Y + 1.




