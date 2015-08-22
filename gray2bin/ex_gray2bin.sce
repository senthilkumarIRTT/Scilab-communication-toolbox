//Scilab Example Main program to find
//binary equivalent of gray value
//Note : This example program and function both nust be in same folder
clear;
clc;
x= input('Enter the gray value=')
exec('gray2bin.sci')
y = gray2bin(x)
disp(y,'binary value of given gray value =')
