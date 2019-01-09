/* * * * * * * * * * * * * * * *
 *	 Programmer: Nick Rohde    *     
 *	 Course:     CS362         * 
 *	 Project:    Lab 3 - BST   *     
 *	 Instructor: Arne Leitert  *    
 *	 Date:       11 Feb 2018   *     
 * * * * * * * * * * * * * * * */
 

contains([H | T], X) :- H = X; contains(T,X).


median(A,B,C,A) :- (B =< A, A =< C); (C =< A, A =< B).
median(A,B,C,B) :- (A =< B, B =< C); (C =< B, B =< A).
median(A,B,C,C) :- (A =< C, C =< B); (B =< C, C =< A).


largerEqual([],_).
largerEqual([H | T],X) :- H =< X, largerEqual(T,X).


max(L, X) :- contains(L,X), largerEqual(L,X).
