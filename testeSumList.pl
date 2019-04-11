sumList(List,Sum):- sumList_tr(List,0,Sum).
sumList_tr([],Sum,Sum).
sumList_tr([H|T], PartialSum,Sum):-
    NewPartialSum is H + PartialSum,
    sumList_tr(T, NewPartialSum,Sum).