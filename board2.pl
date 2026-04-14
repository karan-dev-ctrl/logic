:- dynamic c/2.

field([],_).
field([X|XC], YC):- field1(X,YC), field(XC,YC).


field1(_,[]).
field1(X,[Y|YC]):- assert(c([X,Y],' ')), field1(X,YC).


p_field:-
    findall(X,c([X,_],_),XL), 
    sort(XL,XS),              
    findall(Y,c([_,Y],_),YL),
    sort(YL,Y1S),
    reverse(Y1S,YS), 
    write('   '),
    p_line(XS), nl,
    p_field1(YS,XS).


p_field1([],_).
p_field1([Y|YL],XL):-
    write(Y),
    write(' | '),
    p_field2(Y,XL),nl,
    write('   '),
    p_line(XL),nl,
    p_field1(YL,XL).


p_field2(_,[]).
p_field2(Y, [X|XL]):-
    c([X,Y],P),
    write(P),
    write(' | '),
    p_field2(Y,XL).


p_line([]).
p_line([_|XL]):-
    write('--- '),
    p_line(XL).


o(1,[X,Y],[X1,Y],[X2,Y],[X3,Y]):-
    X1 is X+1,
    X2 is X+2,
    X3 is X+3.

o(2,[X,Y],[X1,Y1],[X2,Y2],[X3,Y3]):-
    X1 is X+1, Y1 is Y+1,
    X2 is X+2, Y2 is Y+2,
    X3 is X+3, Y3 is Y+3.

o(3,[X,Y],[X,Y1],[X,Y2],[X,Y3]):-
    Y1 is Y+1,
    Y2 is Y+2,
    Y3 is Y+3.

o(4,[X,Y],[X1,Y1],[X2,Y2],[X3,Y3]):-
    X1 is X+1, Y1 is Y-1,
    X2 is X+2, Y2 is Y-2,
    X3 is X+3, Y3 is Y-3.
    



win(P):-
    c(C1,P),
    o(_,C1,C2,C3,C4),
    c(C2,P),
    c(C3,P),
    c(C4,P),
    nl,
    write([win,C1,C2,C3,C4]),
    nl,
    p_field.

win(_):-
    nl,
    p_field.
    

%player (user)
move_p(C):-
    c(C,' '),
    retract(c(C,' ')),
    assert(c(C,o)),
    win(o).

reset:-
    retractall(c(_,_)),
    field([0,1,2,3],[0,1,2,3]),
    p_field.


% 1. win if possible
move_c:-
    c(C1,x),
    o(ID,C1,C2,C3,C4),
    c(C2,x),
    c(C3,x),
    c(C4,' '),
    retract(c(C4,' ')),
    assert(c(C4,x)),
    write([C4,ID,'xxx_ -> win']), nl,
    win(x).

% 2. block player if needed
move_c:-
    c(C1,o),
    o(ID,C1,C2,C3,C4),
    c(C2,o),
    c(C3,o),
    c(C4,' '),
    retract(c(C4,' ')),
    assert(c(C4,x)),
    write([C4,ID,'block ooo_']), nl,
    win(x).

% 3. fallback move
move_c:-
    c(C,' '),
    retract(c(C,' ')),
    assert(c(C,x)),
    write([C,'empty place']), nl,
    win(x).


