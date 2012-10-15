% PS2P04 Arnold Christopher Koroa A0092101Y

simpl(E,E) :- (integer(E),!);(atom(E),!).
simpl(- 1,SE) :- !, simpl((-1),SE).
simpl(-E,-E) :- !, simpl(E,E).
simpl(0+E,SE) :- !,simpl(E,SE).
simpl(E+0,SE) :- !,simpl(E,SE).
simpl(E-0,SE) :- !,simpl(E,SE).
simpl(1*E,SE) :- !,simpl(E,SE).
simpl(E*1,SE) :- !,simpl(E,SE).
simpl(E/1,SE) :- !,simpl(E,SE).
simpl(E/1,SE) :- !,simpl(E,SE).
simpl(0-E,SE) :- !,simpl(-E,SE).
simpl(E*(-1),SE) :- !,simpl(-E,SE).
simpl(E/(-1),SE) :- !,simpl(-E,SE).
simpl((-1)*E,SE) :- !,simpl(-E,SE).
simpl(E1+(-E2),SE) :- !,simpl(E1-E2,SE).
simpl(E,SE) :-
	!,
	E =.. [Op,EL,ER],
	simpl(EL,SE1),
	simpl(ER,SE2),
	ES =.. [Op,SE1,SE2],
	(   (not(EL=SE1);not(ER=SE2)) ->
	        simpl(ES,SE);
	        SE = ES
	).








