(* Makes a list containing all integers in (0,n] *)
fun makeLst n =	
	if n > 1 (* Recursive case *)
		then makeLst(n-1) @ [n]
		
	else if n = 1 (* Base case *)
		then [1]
		
	else (* Catch for invalid input *)
		[];


(* Removes all multiples of k from list *)
fun removeMult (lst, k) =
	if null lst (* Base case *)
		then lst
		
	else if hd(lst) mod k = 0 (* Recursive case *)
		then removeMult( tl(lst), k)
		
	else (* Recursive case *)
		hd(lst) :: removeMult( tl(lst), k);


(* Turns a list containing all numbers from 2 to n into a list containing all primes from 2 to n *)
fun  sieveOfEratosthenes(lst, k) = 
	if null lst (* Catch for invalid input *)
		then lst

	else if k = 2 (* Base 2 case *)
		then k :: removeMult(lst, k)
		
	else (* Recursive case *)
		sieveOfEratosthenes( k :: removeMult(lst,k), k-1);
		(* remove all multiples of k, and then go to next number *)
		

(* Finds the upper limit for sieveOfEratosthenes function *)
fun primesHelper (lst, max) = 
	sieveOfEratosthenes(lst, floor( Math.sqrt( real(max)))); (* find square root of max, the upper limit to check for primes *)
	

(* Creates a list of all primes between 1 and n *)
fun primes (n) =
	(* Normal case *)
	if n > 2 
		then primesHelper( tl( makeLst(n)), n) (* Remove 1 right away *)
		
	(* Trivial cases *)
	else if n = 2 
		then [2]
		
	else 
		[];