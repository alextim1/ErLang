-module(p05).
-export([reverse/1]).

reverse (A) -> rev(A,[]).

rev ([H|T], B) -> 
	rev(T,[H|B]);
rev([], B) -> B.