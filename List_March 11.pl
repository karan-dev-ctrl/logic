
% H is anonyumus

number([],0).
number([H|T], N) :- number(T,N1) , N is  N1+1.
       %[a|b,c]            (b,c),2 ....
       %[b|[c]]            (c),1 ....
       %[c|[]]            (), 0....

%number([a,b,c], X).





ent(X, [X|_]).
ent(X,[_|T]):-ent(X,T).

%ent(a,[b,a,c]).
%ent(X,[5,6,7,8,9,10]), X>6.

pick(X,[],[]).

pick(X,[H|T],[H|T1]):-H>X, pick(X,T,T1).

pick(X,[H|T], T1  ):- not(H>X), pick(X,T,T1).

%?- pick(6,[5,6,7,8],X).
%X = [7, 8] .


even([],[]).

even([H|T],[H|T1]):- 0 is H mod 2, even(T,T1).

even([H|T], T1  ):- (1 is H mod 2), even(T,T1).
%?- even([1,2,3,4,5], X).
%X = [2, 4] .


pref(N,W,P):-atom_chars(W,WL),
             append(PL,SL,WL),
             length(PL,N),
             atom_chars(P,PL).

%?- pref(2, hello, P).
%P = he



init(1).
final([3]).
d(1,a,2).
d(1,b,1).
d(2,a,3).
d(2,b,2).
d(3,a,1).
d(3,b,3).

start:-write('Write a word:  '), read(W),
      atom_chars(W,WL),
      init(S),
      da(S,WL).

da(S,[]):-final(F), member(S,F), write(S), write('...'), write([]).
da(S,[H|WL]):-write(S), write('...'), atom_chars(WLC,[H|WL]),write(WLC),nl,
    d(S,H,S1),
    da(S1,WL).
