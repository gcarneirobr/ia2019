line_terminal_stations(Line,S1, S2) :- 
    link(S1, S3, Line),
    line_terminal_stations(Line, S3, _).

