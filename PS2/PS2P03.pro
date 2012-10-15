%PS2P03 Arnold Christopher Koroa A0092101Y

% base cases
derive(Expression,_,D) :-
	integer(Expression),
	D = 0,
	!.
derive(Expression,Var,D) :-
	atom(Expression),
	Expression = Var,
	D = 1,
	!.
derive(Expression,_,D) :-
	atom(Expression),
	D = 0,
	!.
% (f(x)+-g(x))' = f'(x) +- g'(X)
derive(Expression,Var,D) :-
	Expression =.. [Op,E1,E2],
	member(Op,[+,-]),
	derive(E1,Var,E1d),
	derive(E2,Var,E2d),
	D =.. [Op,E1d,E2d],
	!.
% (f(x)g(x))' = f'(x)g(x) + f(x)g'(x)
derive(Expression,Var,D) :-
	Expression =.. [Op,E1,E2],
	Op = *,
	derive(E1,Var,E1d),
	derive(E2,Var,E2d),
	D1 =.. [*,E1d,E2],
	D2 =.. [*,E1,E2d],
	D =.. [+,D1,D2],
	!.
% (f(x)/g(x))' =
% (f'(x)g(x) - f(x)g'(x)) / (g(x)g(x))
derive(Expression,Var,D) :-
	Expression =.. [Op,E1,E2],
	Op = /,
	derive(E1,Var,E1d),
	derive(E2,Var,E2d),
	D1 =.. [*,E1d,E2],
	D2 =.. [*,E1,E2d],
	Dnum =.. [-,D1,D2],
	Ddenom =.. [*,E2,E2],
	D =.. [/,Dnum,Ddenom],
	!.








