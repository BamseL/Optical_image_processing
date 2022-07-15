clc;clear all;
A = [1 2 3 4 5;2 3 4 5 6;1 2 3 4 5;5 4 3 2 1; 1 2 3 4 5];
B = [1 2 3;4 5 6;7 8 9];
C_full = conv2(A,B,'full');
C = conv2(A,B');
C_same = conv2(A,B,'same');
C_valid = conv2(A,B,'valid');