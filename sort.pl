% =========================================
% Facts for findall/sort practice
% =========================================

c([1,2], x).
c([2,3], o).
c([1,4], x).
c([3,2], o).
c([2,2], x).
c([3,4], o).

% =========================================
% 1. Predict output of sort/2
% Run these queries manually
% =========================================

% ?- sort([3,1,2,3,2], X).
% ?- sort([b,a,c,a], X).
% ?- sort([5,4,5,1,2], X).
% ?- sort([7,7,7,7], X).
% ?- sort([3,2,1], X).

% =========================================
% 2. Difference between sort/2 and msort/2
% Run these queries manually
% =========================================

% ?- sort([3,1,2,3,2], X).
% ?- msort([3,1,2,3,2], X).

% ?- sort([4,1,4,2,2], X).
% ?- msort([4,1,4,2,2], X).

% ?- sort([a,c,b,a], X).
% ?- msort([a,c,b,a], X).

% =========================================
% 3. Use with findall
% =========================================

% Collect all X values
all_x(XL) :-
    findall(X, c([X,_],_), XL).

% Collect sorted unique X values
sorted_x(XS) :-
    findall(X, c([X,_],_), XL),
    sort(XL, XS).

% Collect all Y values
all_y(YL) :-
    findall(Y, c([_,Y],_), YL).

% Collect sorted unique Y values
sorted_y(YS) :-
    findall(Y, c([_,Y],_), YL),
    sort(YL, YS).

% Example queries:
% ?- all_x(XL).
% ?- sorted_x(XS).
% ?- all_y(YL).
% ?- sorted_y(YS).

% =========================================
% 4. True / False queries
% Run these directly
% =========================================

% ?- sort([2,1,2], [1,2]).
% ?- sort([2,1,2], [1,2,2]).
% ?- sort([3,2,1], [1,2,3]).
% ?- sort([3,2,1], [3,2,1]).
% ?- sort([a,b,a], [a,b]).
% ?- sort([a,b,a], [b,a]).

% =========================================
% 5. Fill missing variable values
% Run these directly
% =========================================

% ?- sort([X,2,1], [1,2,3]).
% ?- sort([3,X,1], [1,2,3]).
% ?- sort([X,X,1], [1,2]).
% ?- sort([a,X,b], [a,b,c]).
% ?- sort([X,4,2], [2,4,5]).

% =========================================
% Optional helper predicates to check answers
% =========================================

q1(X) :- sort([3,1,2,3,2], X).
q2(X) :- sort([b,a,c,a], X).
q3(X) :- sort([5,4,5,1,2], X).
q4(X) :- sort([7,7,7,7], X).
q5(X) :- sort([3,2,1], X).

q6_sort(X)  :- sort([3,1,2,3,2], X).
q6_msort(X) :- msort([3,1,2,3,2], X).

q7_sort(X)  :- sort([4,1,4,2,2], X).
q7_msort(X) :- msort([4,1,4,2,2], X).

q8_sort(X)  :- sort([a,c,b,a], X).
q8_msort(X) :- msort([a,c,b,a], X).