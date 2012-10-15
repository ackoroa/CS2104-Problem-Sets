% PS3P05 Arnold Christopher Koroa A0092101Y

% wrapper predicate
mul(A,B,Result) :-
	mul(A,B,[0],[0],Result).

% add A to A for B times
mul(A,B,Index,CurrVal,Result) :-
	Index \= B,
	add(CurrVal,A,TRes),
	add(Index,[1],NIndex),
	mul(A,B,NIndex,TRes,Result),
	!.
mul(_,_,_,Result,Result).

%%%%%%%%%%% Included PS3P04 Solution %%%%%%%%%%%%%%

% fullBitAdder(X,Y,Cin,Result,Cout).
% used to compute the addition
fullBitAdder(0,0,0,0,0) :- !.
fullBitAdder(1,0,0,1,0) :- !.
fullBitAdder(0,1,0,1,0) :- !.
fullBitAdder(1,1,0,0,1) :- !.
fullBitAdder(0,0,1,1,0) :- !.
fullBitAdder(1,0,1,0,1) :- !.
fullBitAdder(0,1,1,0,1) :- !.
fullBitAdder(1,1,1,1,1) :- !.

% wrapper predicate
add(A,B,Result) :- add(A,B,Result,0,0).

%% Adds A[N],B[N] and Cin and store results
%% at Result[N]. Continue to add bit N+1
% both A[n] and B[N] is available
add(A,B,Result,N,Cin) :-
	length(A,LenA),
	length(B,LenB),
	M is N+1,
	M=<LenA,
	M=<LenB,
	nth0(N,A,X),
	nth0(N,B,Y),
	fullBitAdder(X,Y,Cin,Res,Cout),
	nth0(N,Result,Res),
	add(A,B,Result,M,Cout),
	!.
% no more element in B
add(A,B,Result,N,Cin) :-
	length(A,LenA),
	M is N+1,
	M=<LenA,
	nth0(N,A,X),
	fullBitAdder(X,0,Cin,Res,Cout),
	nth0(N,Result,Res),
	add(A,B,Result,M,Cout),
	!.
% no more element in A
add(A,B,Result,N,Cin) :-
	length(B,LenB),
	M is N+1,
	M=<LenB,
	nth0(N,B,Y),
	fullBitAdder(0,Y,Cin,Res,Cout),
	nth0(N,Result,Res),
	add(A,B,Result,M,Cout),
	!.
% no more element in A an B, fix Result length
add(_,_,Result,M,Cout) :-
	Cout = 0 -> length(Result,M);
	(   nth0(M,Result,Cout),
	    L is M+1,
	    length(Result,L)
	).












