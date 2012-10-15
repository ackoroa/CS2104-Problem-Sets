% PS3P03 Arnold Christopher Koroa A0092101Y

% if n=0, it's the original image
tile(0,Img,Dest) :- writef('%s%d%s%d%s\n',["convert -scale 100%x100% ", Img, ".jpg ", Dest, ".jpg"]).

tile(N,Img,Dest) :-
	M is N-1,
	atomic_list_concat([temp,M],Temp0),
	atomic_list_concat([temp,M,a],TempA),
	atomic_list_concat([temp,M,b],TempB),
	tile(M,Img,Temp0),
	ma( TempA=beside(rotate(rotate(rotate(Temp0))),rotate(rotate(Img)));
	    TempB=beside(Img,rotate(Img));
	    Dest=beside(rotate(TempA),rotate(TempB)) ),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Included Solution for PS3P02 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% translate the predicate ma to the predicate montage from PS3P01
ma(X=GDE) :- montage(GDE,X).
ma(X=GDE;MA) :-
	montage(GDE,X),
	ma(MA).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Included Solution for PS3P01 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

montage(X,Dest) :- atom(X),atom(Dest),!.

% rotate an atom directly
montage(rotate(Img),Dest) :-
	atom(Img),
	writef('%s%d%s%d%s\n',["convert -rotate 90 ", Img, ".jpg ", Dest, ".jpg"]),
	!.
% first process the nested graphic description expression
% then rotate the result
montage(rotate(GDE),Dest) :-
	atomic_concat(Dest,r,Img),
	montage(GDE,Img),
	writef('%s%d%s%d%s\n',["convert -rotate 90 ", Img, ".jpg ", Dest, ".jpg"]),
	!.

% scale then append atoms directly
montage(beside(Img1,Img2),Dest) :-
	atom(Img1),
	atom(Img2),

	atomic_concat(Img1,s,Img1s),
	writef('%s%d%s%d%s\n',["convert -scale 50%x100% ", Img1, ".jpg ", Img1s, ".jpg"]),
	atomic_concat(Img2,s,Img2s),
	writef('%s%d%s%d%s\n',["convert -scale 50%x100% ", Img2, ".jpg ", Img2s, ".jpg"]),

	writef('%s%d%s%d%s%d%s\n',["convert +append ", Img1s, ".jpg ", Img2s, ".jpg ", Dest, ".jpg"]),
	!.
% first process the nested graphic description expression
% then scale and append the result
montage(beside(Img1,GDE2),Dest) :-
	atom(Img1),
	atomic_concat(Dest,b2,Img2),
	montage(GDE2,Img2),

	atomic_concat(Img1,s,Img1s),
	writef('%s%d%s%d%s\n',["convert -scale 50%x100% ", Img1, ".jpg ", Img1s, ".jpg"]),
	atomic_concat(Img2,s,Img2s),
	writef('%s%d%s%d%s\n',["convert -scale 50%x100% ", Img2, ".jpg ", Img2s, ".jpg"]),

	writef('%s%d%s%d%s%d%s\n',["convert +append ", Img1s, ".jpg ", Img2s, ".jpg ", Dest, ".jpg"]),
	!.
montage(beside(GDE1,Img2),Dest) :-
	atom(Img2),
	atomic_concat(Dest,b1,Img1),
	montage(GDE1,Img1),

	atomic_concat(Img1,s,Img1s),
	writef('%s%d%s%d%s\n',["convert -scale 50%x100% ", Img1, ".jpg ", Img1s, ".jpg"]),
	atomic_concat(Img2,s,Img2s),
	writef('%s%d%s%d%s\n',["convert -scale 50%x100% ", Img2, ".jpg ", Img2s, ".jpg"]),

	writef('%s%d%s%d%s%d%s\n',["convert +append ", Img1s, ".jpg ", Img2s, ".jpg ", Dest, ".jpg"]),
	!.
montage(beside(GDE1,GDE2),Dest) :-
	atomic_concat(Dest,b1,Img1),
	montage(GDE1,Img1),
	atomic_concat(Dest,b2,Img2),
	montage(GDE2,Img2),

	atomic_concat(Img1,s,Img1s),
	writef('%s%d%s%d%s\n',["convert -scale 50%x100% ", Img1, ".jpg ", Img1s, ".jpg"]),
	atomic_concat(Img2,s,Img2s),
	writef('%s%d%s%d%s\n',["convert -scale 50%x100% ", Img2, ".jpg ", Img2s, ".jpg"]),

	writef('%s%d%s%d%s%d%s\n',["convert +append ", Img1s, ".jpg ", Img2s, ".jpg ", Dest, ".jpg"]),
	!.








