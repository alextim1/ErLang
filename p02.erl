-module(p02).
-export([but_last/1]).

but_last([H,H1|[]]) -> [H,H1];

but_last([H|T]) ->
	but_last(T).