% Rule 1 - Base case
% Rule 2 - Recursive case


% counting the number of elements in a list


number([], 0). % base case: the number of elements in an empty list is 0
number([H|T], N) :- number(T, N1), N is N1 + 1. 

% H is the head of the list and T is the tail
%



% Checks if element X exists in a list


ent(X, [X|_]).
ent(X,[_|T]):-ent(X,T).


% Picks/Filters all elements GREATER than X from a list

pick(X,[],[]).

pick(X,[H|T],[H|T1]):-H>X, pick(X,T,T1).

pick(X,[H|T], T1  ):- not(H>X), pick(X,T,T1).


even([],[]).

even([H|T],[H|T1]):- 0 is H mod 2, even(T,T1).

even([H|T], T1  ):- (1 is H mod 2), even(T,T1).



pref(N, W, P) :-
    atom_chars(W, WL),      ← Step 1
    append(PL, SL, WL),     ← Step 2
    length(PL, N),          ← Step 3
    atom_chars(P, PL).     ← Step 4


% N - Length of prefix we want
% W - Word (input)
% P - Prefix (output/result)
% WL - Word as List of characters
% PL - Prefix List — first N characters
% SL - Suffix List — remaining characters (ignored)


% atom_chars(W, WL)
% ```
% > **"Convert word W into a LIST of characters → WL"**
% ```
% W  = hello
% WL = [h, e, l, l, o]

% append(PL, SL, WL)
% ```
% > **"Split WL into two parts — PL (front) and SL (back)"**
% ```
% WL = [h, e, l, l, o]
%       ↓           ↓
% PL = [h, e, l]    SL = [l, o]
%      (prefix)          (suffix)
% ```

% Think of it like:
% ```
% PL  +  SL  =  WL
% [h,e,l] + [l,o] = [h,e,l,l,o]

% length(PL, N)
% ```
% > **"Make sure PL has exactly N characters"**
% ```
% N  = 3
% PL = [h, e, l]   ← length is 3 ✅

atom_chars(P, PL)
```
> **"Convert character list PL back into a word → P"**
```
PL = [h, e, l]
P  = hel
```

---

## Full Trace — `pref(3, hello, P)`
```
STEP 1: atom_chars(hello, WL)
        WL = [h, e, l, l, o]

STEP 2: append(PL, SL, [h,e,l,l,o])
        Many possible splits:
        PL=[]        SL=[h,e,l,l,o]
        PL=[h]       SL=[e,l,l,o]
        PL=[h,e]     SL=[l,l,o]
        PL=[h,e,l]   SL=[l,o]      ← ✅ this one!
        PL=[h,e,l,l] SL=[o]
        ...

STEP 3: length(PL, 3)
        Filters only where PL has 3 elements
        PL = [h, e, l]  ✅

STEP 4: atom_chars(P, [h,e,l])
        P = hel  ✅
```

---

% ## Visual Flow
% ```
% Input:   N=3,  W=hello

% STEP 1:  hello  →  [h, e, l, l, o]
%                     ↓
% STEP 2:  split  →  [h, e, l] + [l, o]
%                     ↓
% STEP 3:  check  →  length = 3 ✅
%                     ↓
% STEP 4:  join   →  [h, e, l]  →  hel

% Output:  P = hel ✅