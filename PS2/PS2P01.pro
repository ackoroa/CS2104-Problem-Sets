% PS2P01 - Arnold Christopher Koroa A0092101Y
% Assumes the expression is a valid mathematical one.
% e.g. the givan example in the problem statement
% will be evaluated to false because there's a
% missing operator between f and the open bracket

count(E,_,0) :- atom(E),!.
count(E,_,0) :- integer(E),!.

% increase count if Op == Op1
% recursively count E1 and E2
count(E,Op,N) :-
	E =.. [Op1,E1,E2],
	Op = Op1,
	count(E1,Op,N1),
	count(E2,Op,N2),
	N is N1+N2+1,!.

% Op != Op1, do not increase count
% recursively count E1 and E2
count(E,Op,N) :-
	E =.. [_,E1,E2],
	count(E1,Op,N1),
	count(E2,Op,N2),
	N is N1+N2,!.
