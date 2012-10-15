%PS4P01 Arnold Chritopher Koroa A0092101Y

:- op(500,yfx,;).

fractal(Var=Exp,Level,Unit):-
	tell('PS4P01.py'),
	writeln('from turtle import *'),
	writeln('delay(0)'),
	fractal(Var,Exp,Level,Unit,Exp),!,
	writeln('input("Press Enter to continue...")'),
	told.

fractal(Var,Var,1,Unit,_):-
	writeln(forward(Unit)).
fractal(Var,Var,Level,Unit,Exp):-
	NL is Level-1,
	fractal(Var,Exp,NL,Unit,Exp).

fractal(_,left(Angle),_,_,_) :-
	writeln(left(Angle)).
fractal(_,right(Angle),_,_,_) :-
	writeln(right(Angle)).

fractal(Var,E1;E2,Level,Unit,Exp) :-
	fractal(Var,E1,Level,Unit,Exp),
	fractal(Var,E2,Level,Unit,Exp).












