-module(p06).
-export([is_polindrome/1]).


reverse (A) -> rev(A,[]).

rev ([H|T], B) -> 
	rev(T,[H|B]);
rev([], B) -> B.


is_polindrome(A) -> check(A, reverse(A)).

check(A,A) -> true;
check(_,A) -> false.
	
	
		
	