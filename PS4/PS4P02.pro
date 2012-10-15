%PS4P02 Arnold Chritopher Koroa A0092101Y

:- op(500,yfx,;).

fractal(Var=Exp,Level,Unit):-
	tell('PS4P02.py'),
	writeln('from turtle import *'),
	writeln('delay(0)'),
	write('def '), write(Var), writeln('(level,unit) :'),
	writeln('    if level == 0 :'),
	writeln('        forward(unit)'),
	writeln('    else:'),
	fractal(Var,Exp),!,
	writeln(''),
	write(Var),write('('),write(Level),
	write(','),write(Unit),writeln(')'),
	writeln('input("Press Enter to continue...")'),
	told.

fractal(Var,Var):-
	write('        '),write(Var),
	writeln('(level-1,unit)').

fractal(_,left(Angle)) :-
	write('        '),writeln(left(Angle)).
fractal(_,right(Angle)) :-
	write('        '),writeln(right(Angle)).

fractal(Var,E1;E2) :-
	fractal(Var,E1),
	fractal(Var,E2).










