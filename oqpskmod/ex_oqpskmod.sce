clear;
clc;
exec('genqammod.sci')
exec('oqpskmod.sci')
M =4;
x =0:M-1;
y = oqpskmod(x)
disp(y,'QPSK modulated output=')
