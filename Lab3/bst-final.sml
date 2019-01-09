(* Programmer: Nick Rohde        *)
(* Course:     CS362             *)
(* Project:    Lab 3 - BST       *)
(* Instructor: Arne Leitert      *)
(* Date:       4 Feb 2018        *)

Control.Print.printDepth := 500;

(* left subtree, right subtree, key, value *)
datatype BST = Empty | Node of BST * BST * int * int;

fun parsePost [] = Empty
|   parsePost lst =
    let
        fun pP (stack, (0,k,v)::str) = pP(Node(Empty, Empty, k, v)::stack, str)
        |   pP (L::stack, (1,k,v)::str) = pP(Node(L, Empty, k, v)::stack, str)
        |   pP (R::stack, (2,k,v)::str) = pP(Node(Empty, R, k, v)::stack, str)
        |   pP (R::L::stack, (3,k,v)::str) = pP(Node(L, R, k, v)::stack, str)
        |   pP (T::stack, []) = T;
    in
        pP([],lst)
    end;

val exTree0 = []
val exTree1 = [(0,1,7),(0,3,3),(3,2,2)];
val exTree2 = [(0,2,2),(2,1,1),(0,4,4),(3,3,3),(0,6,6),(1,7,7),(3,5,5)];
val exTree3 = [(0,1,1),(0,4,4),(1,5,5),(3,2,2),(0,8,8),(0,15,15),(2,14,14),(3,11,11)];



fun find(Empty, _) = nil
|   find(Node(L, R, K, V), key) =
		if K = key 
			then [V]
			
		else if K < key
			then find(L, key)

		else 
			find(R, key);

		
(* finds successor of a node -- leftmost descendant of right subtree *)
fun getSuccessor(Empty) = Empty
|   getSuccessor(Node(Empty, R, K, V)) = Node(Empty, R, K, V)
|   getSuccessor(Node(L, R, _, _)) = getSuccessor(L);


fun insert(Empty, key, v) = Node(Empty, Empty, key, v)
|   insert(Node(L, R, k, v), key, value) = 
		if key = k
			then Node(L, R, k, value)
			
		else if key > k
			then Node(L, insert(R, key, value), k,v)
			
		else
			Node(insert(L, key, value), R, k, v);


fun postorder(Empty) = []
|   postorder(Node(Empty, Empty, k, v)) = [(0,k,v)]
|   postorder(Node(Empty, R, k, v)) = postorder(R) @ [(2,k,v)]
|   postorder(Node(L, Empty, k, v)) = postorder(L) @ [(1,k,v)]
|   postorder(Node(L, R, k, v)) = postorder(L) @ postorder(R) @ [(3,k,v)];	


fun delete(Empty, _) = Empty
|   delete(Node(Empty, Empty, K, V), key) = 
		if K = key
			then Empty
			
		else (* key does not exist in tree *)
			Node(Empty, Empty, K, V)
			
|   delete(Node(Empty, R, K, V), key) =
		if K = key
			then R
			
		else if K < key
			then Node(Empty, delete(R, key), K, V)
			
		else (* key does not exist in tree *)
			Node(Empty, R, K, V)
			
|   delete(Node(L, Empty, K, V), key) =
		if K = key 
			then L
			
		else if K > key
			then Node(delete(L, key), Empty, K, V)
			
		else (* key does not exist in tree *)
			Node(L, Empty, K, V)
			
|   delete(Node(L, R, K, V), key) = 
		if K = key
			then let
				val Node(a,b,c,d) = getSuccessor(R) 
			in
				Node(L,delete(R,c),c,d) (* replace this node with successor *)
			end

		else if key > K
			then Node(L, delete(R,key), K, V)
			
		else
			Node(delete(L, key), R, K, V);

fun trimMin(Empty,_) = Empty
|   trimMin(Node(L,R,k,v),min) =
	if k < min 
		then trimMin(R, min)
	else
		Node(trimMin(L,min), R, k, v);

fun trimMax(Empty,_) = Empty
|   trimMax(Node(L,R,k,v),max) =
	if k > max
		then trimMax(L,max)
	else
		Node(L, trimMax(R,max),k,v);

fun subtree(Empty, _,_) = Empty	
|   subtree(Node(L, R, k, v), min, max) =
		if k < min (* all values in left subtree are smaller than min and can be ignored *)
			then subtree(R,min,max)
	
		else if k > max (* all values in right subtree are larger than max and can be ignored *)
			then subtree(L, min,max)

		else
			Node(trimMin(L,min), trimMax(R, max), k, v);






