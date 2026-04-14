
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

# retractall(c(_,_)).
# field([0,1], [5,6]).
# p_field.