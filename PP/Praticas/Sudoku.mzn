% sudoku solver
include "alldifferent.mzn";

int: S;
int: N = S * S;

set of int: PuzzleRange = 1..N;
set of int: SubSquareRange = 1..S;

array[1..N, 1..N] of 0..N: start; % 0 represents an empty square
array[1..N, 1..N] of var PuzzleRange: puzzle;

% fill initial grid
constraint forall(i,j in PuzzleRange)(
  if start[i,j] > 0 then puzzle[i,j] = start[i,j] else true endif );

% all different in rows
constraint forall(i,j in PuzzleRange)(
  alldifferent([puzzle[i,j] | j in PuzzleRange]));

% all different in columns
constraint forall(i,j in PuzzleRange)(
  alldifferent([puzzle[i,j] | i in PuzzleRange]));

% all different in sub-squares
constraint forall(a, o in SubSquareRange)(
  alldifferent([puzzle[(a-1) *S + a1, (o-1)*S + o1] | a1, o1 in SubSquareRange]));

solve satisfy;