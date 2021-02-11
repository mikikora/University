:- use_module(library(clpfd)).
solve([Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11]) :- 
    Q0 in 0..11, Q1 in 0..11, Q2 in 0..11, Q3 in 0..11, Q4 in 0..11, Q5 in 0..11, Q6 in 0..11,
    Q7 in 0..11, Q8 in 0..11, Q9 in 0..11, Q10 in 0..11, Q11 in 0..11, all_distinct([Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11]),
    abs(Q0 - Q1) #\= abs(0-1), abs(Q0 - Q2) #\= abs(0-2), abs(Q0 - Q3) #\= abs(0-3),
    abs(Q0 - Q4) #\= abs(0-4), abs(Q0 - Q5) #\= abs(0-5), abs(Q0 - Q6) #\= abs(0-6),
    abs(Q0 - Q7) #\= abs(0-7), abs(Q0 - Q8) #\= abs(0-8), abs(Q0 - Q9) #\= abs(0-9),
    abs(Q0 - Q10) #\= abs(0-10), abs(Q0 - Q11) #\= abs(0-11), abs(Q1 - Q0) #\= abs(1-0),
    abs(Q1 - Q2) #\= abs(1-2), abs(Q1 - Q3) #\= abs(1-3), abs(Q1 - Q4) #\= abs(1-4),
    abs(Q1 - Q5) #\= abs(1-5), abs(Q1 - Q6) #\= abs(1-6), abs(Q1 - Q7) #\= abs(1-7),
    abs(Q1 - Q8) #\= abs(1-8), abs(Q1 - Q9) #\= abs(1-9), abs(Q1 - Q10) #\= abs(1-10),
    abs(Q1 - Q11) #\= abs(1-11), abs(Q2 - Q0) #\= abs(2-0), abs(Q2 - Q1) #\= abs(2-1),
    abs(Q2 - Q3) #\= abs(2-3), abs(Q2 - Q4) #\= abs(2-4), abs(Q2 - Q5) #\= abs(2-5),
    abs(Q2 - Q6) #\= abs(2-6), abs(Q2 - Q7) #\= abs(2-7), abs(Q2 - Q8) #\= abs(2-8),
    abs(Q2 - Q9) #\= abs(2-9), abs(Q2 - Q10) #\= abs(2-10), abs(Q2 - Q11) #\= abs(2-11),
    abs(Q3 - Q0) #\= abs(3-0), abs(Q3 - Q1) #\= abs(3-1), abs(Q3 - Q2) #\= abs(3-2),
    abs(Q3 - Q4) #\= abs(3-4), abs(Q3 - Q5) #\= abs(3-5), abs(Q3 - Q6) #\= abs(3-6),
    abs(Q3 - Q7) #\= abs(3-7), abs(Q3 - Q8) #\= abs(3-8), abs(Q3 - Q9) #\= abs(3-9),
    abs(Q3 - Q10) #\= abs(3-10), abs(Q3 - Q11) #\= abs(3-11), abs(Q4 - Q0) #\= abs(4-0),
    abs(Q4 - Q1) #\= abs(4-1), abs(Q4 - Q2) #\= abs(4-2), abs(Q4 - Q3) #\= abs(4-3),
    abs(Q4 - Q5) #\= abs(4-5), abs(Q4 - Q6) #\= abs(4-6), abs(Q4 - Q7) #\= abs(4-7),
    abs(Q4 - Q8) #\= abs(4-8), abs(Q4 - Q9) #\= abs(4-9), abs(Q4 - Q10) #\= abs(4-10),
    abs(Q4 - Q11) #\= abs(4-11), abs(Q5 - Q0) #\= abs(5-0), abs(Q5 - Q1) #\= abs(5-1),
    abs(Q5 - Q2) #\= abs(5-2), abs(Q5 - Q3) #\= abs(5-3), abs(Q5 - Q4) #\= abs(5-4),
    abs(Q5 - Q6) #\= abs(5-6), abs(Q5 - Q7) #\= abs(5-7), abs(Q5 - Q8) #\= abs(5-8),
    abs(Q5 - Q9) #\= abs(5-9), abs(Q5 - Q10) #\= abs(5-10), abs(Q5 - Q11) #\= abs(5-11),
    abs(Q6 - Q0) #\= abs(6-0), abs(Q6 - Q1) #\= abs(6-1), abs(Q6 - Q2) #\= abs(6-2),
    abs(Q6 - Q3) #\= abs(6-3), abs(Q6 - Q4) #\= abs(6-4), abs(Q6 - Q5) #\= abs(6-5),
    abs(Q6 - Q7) #\= abs(6-7), abs(Q6 - Q8) #\= abs(6-8), abs(Q6 - Q9) #\= abs(6-9),
    abs(Q6 - Q10) #\= abs(6-10), abs(Q6 - Q11) #\= abs(6-11), abs(Q7 - Q0) #\= abs(7-0),
    abs(Q7 - Q1) #\= abs(7-1), abs(Q7 - Q2) #\= abs(7-2), abs(Q7 - Q3) #\= abs(7-3),
    abs(Q7 - Q4) #\= abs(7-4), abs(Q7 - Q5) #\= abs(7-5), abs(Q7 - Q6) #\= abs(7-6),
    abs(Q7 - Q8) #\= abs(7-8), abs(Q7 - Q9) #\= abs(7-9), abs(Q7 - Q10) #\= abs(7-10),
    abs(Q7 - Q11) #\= abs(7-11), abs(Q8 - Q0) #\= abs(8-0), abs(Q8 - Q1) #\= abs(8-1),
    abs(Q8 - Q2) #\= abs(8-2), abs(Q8 - Q3) #\= abs(8-3), abs(Q8 - Q4) #\= abs(8-4),
    abs(Q8 - Q5) #\= abs(8-5), abs(Q8 - Q6) #\= abs(8-6), abs(Q8 - Q7) #\= abs(8-7),
    abs(Q8 - Q9) #\= abs(8-9), abs(Q8 - Q10) #\= abs(8-10), abs(Q8 - Q11) #\= abs(8-11),
    abs(Q9 - Q0) #\= abs(9-0), abs(Q9 - Q1) #\= abs(9-1), abs(Q9 - Q2) #\= abs(9-2),
    abs(Q9 - Q3) #\= abs(9-3), abs(Q9 - Q4) #\= abs(9-4), abs(Q9 - Q5) #\= abs(9-5),
    abs(Q9 - Q6) #\= abs(9-6), abs(Q9 - Q7) #\= abs(9-7), abs(Q9 - Q8) #\= abs(9-8),
    abs(Q9 - Q10) #\= abs(9-10), abs(Q9 - Q11) #\= abs(9-11), abs(Q10 - Q0) #\= abs(10-0),
    abs(Q10 - Q1) #\= abs(10-1), abs(Q10 - Q2) #\= abs(10-2), abs(Q10 - Q3) #\= abs(10-3),
    abs(Q10 - Q4) #\= abs(10-4), abs(Q10 - Q5) #\= abs(10-5), abs(Q10 - Q6) #\= abs(10-6),
    abs(Q10 - Q7) #\= abs(10-7), abs(Q10 - Q8) #\= abs(10-8), abs(Q10 - Q9) #\= abs(10-9),
    abs(Q10 - Q11) #\= abs(10-11), abs(Q11 - Q0) #\= abs(11-0), abs(Q11 - Q1) #\= abs(11-1),
    abs(Q11 - Q2) #\= abs(11-2), abs(Q11 - Q3) #\= abs(11-3), abs(Q11 - Q4) #\= abs(11-4),
    abs(Q11 - Q5) #\= abs(11-5), abs(Q11 - Q6) #\= abs(11-6), abs(Q11 - Q7) #\= abs(11-7),
    abs(Q11 - Q8) #\= abs(11-8), abs(Q11 - Q9) #\= abs(11-9), abs(Q11 - Q10) #\= abs(11-10),
   
    labeling([ff], [Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11]).

:- solve(X), write(X), nl.
