
# A, B, C, D are all different
# A B C D
# 1 2 3 4

# A\=b,
# b\=c
# c\=d
# d\=a
# c\=a
# b\=d

# ?- fill(A,B,C,D).
# ?- fill(A,B,3,D).

n(1).
n(2).
n(3).
n(4).
fill(A,B,C,D):-
    n(A), n(B), A\=B,
    n(C),n(D), C\=D, C\=A, D\=B, A\=D, B\=C.



f(0,1).
f(N,F):-
    N>0,
    N1 is N-1,
    f(N1,F1),
    F is F1 * N.


fib(1,0).
fib(2,1).
fib(N,R):-
    N>2,
    N1 is N-1,
    N2 is N-2,
    fib(N1,F1),
    fib(N2,F2),
    R is F1+F2.

# ?- fib(1,R).
# R = 0.

# ?- fib(2,R).
# R = 1.


nat(0).
nat(N):-
    N>0,
    N1 is N-1,
    nat(N1).


nat1(0).
nat1(N):-
    nat1(N1), N is N1+1.

# 0 → 1 → 2 → 3 → ...



e(a,b,1).
e(b,c,2).
e(c,d,3).
e(a,e,4).
e(e,d,5).
path(X,Y,P):-e(X,Y,P).
path(X,Y,P):- e(X,Z,P1), path(Z,Y,P2), P is P1+P2.