(* Programmer: Nick Rohde        *)
(* Course:     CS362             *)
(* Project:    Lab 2 - Quicksort *)
(* Instructor: Arne Leitert      *)
(* Date:       21 Jan 2018       *)

Control.Print.printLength := 500; (* To make all the numbers show up *)


fun last [a] = a
|	last lst = 
		last(tl(lst));


fun middleHelper(lst, check) =	
		(*  even length        odd length *)
		if null(check) orelse null(tl(check))
			then hd(lst)
		else 
			middleHelper(tl(lst), tl(tl(check)));

			
fun middle lst = 
		middleHelper(lst,lst);	


fun median(a,b,c) = 
		if a >= b andalso a <= c orelse a >= c andalso a <= b (* Checks if a is in between the other two values *)
			then a
		else if c >= b andalso c <= a orelse c >= a andalso c <= b (* Checks if b is in between the other two values *)
			then c
		else 
			b;


fun findPivot(lst) =
		median( hd(lst), middle(lst), last(lst));


(* To make the partitionHelper a bit more understandable *)
fun putIntoList(lst, a) = 
		lst @ [a];


(* Divides list into small and big, which will be the two partitions *)
fun partitionHelper(nil, big, small, _) = (small,big)
|	partitionHelper(lst, big, small, p) = 
		if hd(lst) <= p
			then partitionHelper( ( tl(lst) ), big, putIntoList( small, ( hd(lst) ) ), p)
		else
			partitionHelper( ( tl(lst) ), putIntoList(big, ( hd(lst) ) ), small, p);
		

(* Removes the first occurrence of the pivot element from the list *)
fun removePivot(lst, p) = 
		if hd(lst) = p 
			then tl(lst)
		else 
			hd(lst) :: removePivot(tl(lst), p);


fun partition(nil, _) = ([],[])
|	partition(lst, p) = 
		partitionHelper(removePivot(lst,p), nil, nil, p);


fun quicksort (nil) = nil
|	quicksort (lst) = 
		if null (tl(lst)) (*1 element*)
			then lst
		else			  (*multiple elements*)
			let
				val p = findPivot(lst)
				val b = partition(lst, p)
				val left = #1 b
				val right = #2 b
			in
				quicksort(left) @ [p] @ quicksort(right)
			end;


(* Test Code *)
use "test.sml";

fun isSorted (nil,_) = true
|   isSorted (lst, prev) =
		if hd(lst) >= prev 
			then isSorted(tl(lst), hd(lst))
			
		else 
			false;

			
fun checkSorted(nil) = true
	checkSorted([a]) = true
|   checkSorted(a::lst) = 
		if isSorted(lst, a)
			then checkSorted(lst)
			
		else
			false;
			
			
fun allTrue(nil) = true
|   allTrue(false::_) = false
|   allTrue(true::lst) = allTrue(lst);
		

fun testRun (a:int list list):bool = 
		allTrue(map (checkSorted) (map (quicksort) a));

		
 	