-module(xml).
-export([parse/1]).

%% State machine analyzes input symbols and treats it according to current state.
%% Each state has triggers invoke switching to other state.

%% state switching triggers.

analyze(state_inside_element, <<"</",Rest/binary>>, Name, Text, Tree, Nesting) -> 
	analyze(state_inside_close_tag, Rest, [], [], insert(Tree, [{header, reverse_rec(Text)}, {name, reverse_rec(Name)}], Nesting), Nesting);
	


analyze(state_inside_element, <<"<",Rest/binary>>, Name, Text, Tree, Nesting) -> 
	analyze(state_inside_open_tag, Rest, [], [], insert(Tree, [{header, reverse_rec(Text)}, {name, reverse_rec(Name)}], Nesting), Nesting + 1);
	
analyze(state_inside_open_tag, <<">",Rest/binary>>, Name, _, Tree, Nesting) ->
	analyze(state_inside_element, Rest, Name, [], Tree, Nesting);


	
analyze(state_inside_close_tag, <<">",Rest/binary>>, _, _, Tree, Nesting) -> 
	analyze(state_inside_element, Rest, [], [], Tree, Nesting-1);

%% ordinary behavior inside state.

analyze(state_inside_open_tag, <<Symbol,Rest/binary>>, Name, _, Tree, Nesting) -> 
	analyze(state_inside_open_tag, Rest, [Symbol|Name], [], Tree, Nesting);
	
analyze(state_inside_element, <<Symbol,Rest/binary>>, Name, Text, Tree, Nesting) ->
	analyze(state_inside_element, Rest, Name, [Symbol|Text], Tree, Nesting);
	
analyze(state_inside_close_tag, <<_,Rest/binary>>, _, _, Tree, Nesting) -> 
	analyze(state_inside_close_tag, Rest, [], [], Tree, Nesting);

%% exit.
analyze(state_inside_element, <<>>, _, _, Tree, _) -> Tree.


insert(Tree, Element, 0) when Element =:= [{header, []}, {name, []}]; Element =:= [{header, "\r\n"}, {name, []}] -> Tree;
insert(Tree, Element, 0) -> [Element|Tree];
insert(Tree, Element, Nesting) -> [H|T] = Tree, [insert(H , Element, Nesting-1)|T].



reverse_rec(A) -> rev(A,[]).

rev([H|T], B) -> 
	rev(T,[rev(H,[])|B]);
rev([], B) -> B;
rev(A, _) -> A.


parse(Binary) -> reverse_rec(analyze(state_inside_element, Binary, [], [], [[], {header, empty_header}, {name, root}], 0)).