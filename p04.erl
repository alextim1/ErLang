-module(p04).
-export([len/1]).

len(A) ->	lenth(A,0).



lenth([H|T], N) ->
	lenth(T, N+1);

	
lenth([], N) -> N.