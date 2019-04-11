

podePegarComo(State1, [], []) :-
     move(State1, Move, State2),
     addList(Move, [], [H|T]),
     podePegarComo(State2, [], [H|T]).
     
podePegarComo(State1, [H|T], []) :-
     move(State1, H, State2),
     addList(H, [], [H1|T1]),
     podePegarComo(State2, T, [H1|T1]).

podePegarComo(State1, [], [H|T]) :-
     move(State1, Move, State2),
     addList(Move, [H|T], [H1|T1]),
     podePegarComo(State2, [], [H1|T1]).

podePegarComo(State1, [H|T], [H1|T1]) :-
     move(State1, H, State2),
     addList(H, [H1|T1], [H2|T2]),
     podePegarComo(State2, T, [H2|T2]).
     

     