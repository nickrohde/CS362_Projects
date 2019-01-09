fun insert(lst, x) =
	if null lst then [x]
	else if x > (hd lst) then (hd lst) :: insert((tl lst), x)
	else x :: lst;

fun insertList(L, R) = 
	if null R then L
	else insertList(insert(L, (hd R)), (tl R));

fun insertionSort(lst) = 
	insertList([], lst);