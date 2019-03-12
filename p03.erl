-module(p03).
-export([element_at/2]).

element_at([H|T], 0) -> H;

element_at([H|T], N) ->
	element_at(T, N-1).