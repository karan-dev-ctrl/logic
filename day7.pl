
## Add a cell or remove a cell with this below line

# assert(c([2,3],' ')).   % add a cell
# retract(c([2,3],' ')).  % remove a cell

:- dynamic c/2.


# this is for x-grid creation

field([],_).  #base case [match the base case]

field([X|XC], YC):- field1(X,YC), field(XC,YC).  

#field([0,1], [5,6]).

#example : - field([0,1], [5,6]), x=0, XC=1, YC=5,6 
# field1(X,YC), field(XC,YC). - field1(0, 5,6), field(1,[5,6])

# this for y grid creation
# take x from prvious 
# use the x and y to create an empty cell
# repeat the process

field1(_,[]).

field1(X,[Y|YC]):- assert(c([X,Y],' ')), field1(X,YC).
#field1(X,[Y|YC]) - field(0, 5,6), X=0, y=5, yc=5,6
#assert(c([X,Y],' ')) - c[0,5] -- cell created 
# field1(X,YC). - field1(0,6)

#       X →
#      0     1
# Y ↓
# 5   (0,5) (1,5)
# 6   (0,6) (1,6)


p_field:-
    findall(X,c([X,_],_),XL),  # collect all the xvalues
    sort(XL,XS),              #clean duplicates and store it in XS
    findall(Y,c([_,Y],_),YL),
    sort(YL,Y1S),
    reverse(Y1S,YS),  #reverse for printing the highest value at the top (0,1) --> (1,0)
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


# example Output : 

#       0   1
#    --- --- 
# 6 |   |   |
#    --- --- 
# 5 |   |   |
#    --- --- 


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


o(1,[X,Y],[X1,Y],[X2,Y],[X3,Y],[X4,Y]):-
    X1 is X+1,
    X2 is X+2,
    X3 is X+3,
    X4 is X+4.
o(2,[X,Y],[X1,Y1],[X2,Y2],[X3,Y3],[X4,Y4]):-
    X1 is X+1, Y1 is Y+1,
    X2 is X+2, Y2 is Y+2,
    X3 is X+3, Y3 is Y+3,
    X4 is X+4, Y4 is Y+4.
o(3,[X,Y],[X,Y1],[X,Y2],[X,Y3],[X,Y4]):-
    Y1 is Y+1,
    Y2 is Y+2,
    Y3 is Y+3,
    Y4 is Y+4.
o(4,[X,Y],[X1,Y1],[X2,Y2],[X3,Y3],[X4,Y4]):-
    X1 is X+1,Y1 is Y-1,
    X2 is X+2,Y2 is Y-2,
    X3 is X+3,Y3 is Y-3,
    X4 is X+4, Y4 is Y-4.


# it is a rule for win or not
#c([2,5], x)


win(P):-
    c(C1,P),
    o(_,C1,C2,C3,C4,C5),
    c(C2,P),
    c(C3,P),
    c(C4,P),
    c(C5,P),
    nl,
    write([win,C1,C2,C3,C4,C5]),
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
    field([0,1,2,3,4,5,6,7,8,9],[0,1,2,3,4,5,6,7,8,9]),
    p_field.


move_c:-
    c(C,' '),
    retract(c(C,' ')),
    assert(c(C,x)),
    write([C, 'empty place']),
    win(x).


%xxxxX
move_c:-c(C1,x),
    o(ID,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,x),
    c(C4,x),
    c(C5,' '),
    retract(c(C5,' ')),
    assert(c(C5,x)),
    write([C5,ID, 'xxxxX']),nl,
    win(x).

%cross c3 attack
move_c:-c(C1,' '),
    o(ID1,C1,C2,C3,C4,C5),
    c(C2,x),
    c(C3,' '),
    c(C4,x),
    c(C5,' '),
    c(C6, ' '),
    o(ID2,C6,C7,C3,C8,C9),
    ID1 \= ID2,
    c(C7,x),
    c(C8,x),
    c(C9,' '),
    retract(c(C3,' ')),
    assert(c(C3,x)),
    write([C3,'cross C3']),
    nl,
    win(x).
