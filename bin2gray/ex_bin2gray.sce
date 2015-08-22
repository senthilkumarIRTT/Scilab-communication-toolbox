//Scilab Example Main program to find
//gray equivalent of binary value
//Note : This example program and function both nust be in same folder
clear;
clc;
x=[1 1 1 1 1 1 1]
exec('bin2gray.sci')
y = bin2gray(x)
disp(y,'gray value of given binary value =')
