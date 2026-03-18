l(a,b).
l(b,c).
l(c,d).
l(a,c).
l(e,b).
l(e,d).

edge(X,Y):- l(X,Y).
edge(X,Y):- l(Y,X).

pth(X,Y,P):- pth1(X,Y,[],P).
pth1(X,X,A,P):- reverse([X|A], P).
pth1(X,Y,A,P):- edge(X,Z),not(member(Z,A)), pth1(Z,Y,[X|A],P).






prnt([]).
prnt([H|T]):- write(H),nl,prnt(T).


f(0,0).
f(1,0).
f(2,0).
f(0,2).
f(2,2).

move([X,Y],[X1,Y1]):- X1 is X-1, Y1 is Y+2.
move([X,Y],[X1,Y1]):- X1 is X+1, Y1 is Y-2.


h_move(X,Y,P):- h_move1(X,Y,[],P).
h_move1(X,X,A,P):- reverse([X|A], P).
h_move1(X,Y,A,P):- move(X,Z),f(Z),not(member(Z,A)),h_move1(Z,Y,[X|A],P).

%findall(P,h_move([0,0],[1,0],P),PL),length(PL,N),prnt(PL).
% findall(P,(h_move([0,0],[1,0],P),prnt(P),nl), PL),length(PL,N),prnt(PL).

