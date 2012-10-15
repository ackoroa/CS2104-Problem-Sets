% PS2P02 Arnold Christopher Koroa A0092101Y

% X is divisible by a member of L
divisible(X,L) :-
	member(Y,L),
	X mod Y =:= 0,
	!.

% The next prime number after the
% primes in L is in X
nextPrime([],2).
nextPrime(L,X) :-
	L = [LH|_],
	nextPrime(LH,L,X).
nextPrime(Y,L,X) :-
	X is Y+1,
	\+divisible(X,L),
	!.
nextPrime(Y,L,X) :-
	Y1 is Y+1,
	nextPrime(Y1,L,X).

% generate list of N primes in L
% in descending order
genList(0,[]).
genList(N,L) :-
	M is N-1,
	genList(M,LT),
	L = [LH|LT],
	nextPrime(LT,LH),
	!.

% generate list of N primes
% in ascending order
primes(N,L) :-
	genList(N,L1),
	reverse(L1,L), !.




















