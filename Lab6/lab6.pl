% % % % % % % % % % % % % % % % 
% Programmer:  Nick Rohde     %
% Class     :  CS362_003      %
% Instructor:  Arne Leitert   %
% Project   :  Lab 6          %
% Date      :  4th March 2017 %
% % % % % % % % % % % % % % % %

%minimumHittingSet([[1],[1,2],[1,3],[2,3,4],[4]],X).

contains([H|T], X) :- X = H; contains(T,X).

unionOfAll([], Union, Union).
unionOfAll([H|T], [], Union) :- unionOfAll(T,H,Union),!.
unionOfAll([H|T], Stuff, Union) :- union(H,Stuff,X), unionOfAll(T, X, Union).

isHittingSet([],_).
isHittingSet([H|T],Set) :- member(X,Set), contains(H,X), isHittingSet(T,Set).

minimumHittingSet(Sets, Solution) :- unionOfAll(Sets,[],Union), num(X), subseq(Solution,Union), length(Solution,X), isHittingSet(Sets,Solution),!.

num(1).
num(X) :- num(Y), X is Y+1.


%stolen from lecture slides
subseq([],[]).
subseq([Item | RestX], [Item | RestY]) :- subseq(RestX,RestY).
subseq(X, [_ | RestY]) :- subseq(X,RestY).


