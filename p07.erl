-module(p07).
-export([flatten/1]).


flatt([H], B) -> flatt(H, B);
flatt([[]|T], B) -> flatt(T, B);
flatt([H|T], B) -> flatt(T, flatt(H, B));
flatt(A, B) -> [A|B].


reverse (A) -> rev(A,[]).

rev ([H|T], B) -> rev(T,[H|B]);
rev([], B) -> B.


flatten(A) -> reverse(flatt(A,[])).

