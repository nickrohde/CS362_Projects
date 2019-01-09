
% define that there must be N years, each defined as a tuple of year, a false job, a place, and an actual job, and they are all 3 years apart
solution(0, _, []) :- !. 
solution(N, K, [(Y,_FalseJob,_Place,_ActualJob)|T]) :- Y is K, N1 is N-1, K1 is K+3, solution(N1, K1, T).

% Legionary in east africa
hint1([(_,legionary, eastAfrica, _)|_]).
hint1([_|T]) :- hint1(T).

% Three years after mail man, was server
hint2([(Y,_,_,mailMan),(Y1,_,_,server)|_]) :- Y1 =:= Y + 3.
hint2([_|T]) :- hint2(T).

% In the middle east in 1976
hint3([(Y,_,middleEast,_)|_]) :- Y = 1976.
hint3([_|T]) :- hint3(T).

% while hunter actually hotel clerk; three years later in sovietUnion
hint4([(Y,treasureHunter,_,hotelClerk), (Y1,_,sovietUnion,_)|_]) :- Y1 =:= Y + 3.
hint4([_|T]) :- hint4(T).

% In 1982 taxe driver
hint5([(Y, _, _, taxiDriver)|_]) :- Y = 1982.
hint5([_|T]) :- hint5(T).

% while being spy, was not server
hint6([(_,spy,_,J)|_]):- J \= server.
hint6([_|T]) :- hint6(T).

% define that he was in south america at some point
location([(_,_,southAmerica,_)|_]).
location([_|T]) :- location(T).

% define that he claimed to have been a body guard at some point
fakeJob([(_,bodyGuard,_,_)|_]).
fakeJob([_|T]) :- fakeJob(T).

puzzle(X) :- solution(4, 1973, X), hint1(X), hint2(X), hint3(X), hint4(X), hint5(X), hint6(X), location(X), fakeJob(X).
