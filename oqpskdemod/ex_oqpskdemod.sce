clear;
clc;
exec('genqammod.sci')
exec('oqpskmod.sci')
exec('intdump.sci')
exec('oqpskdemod.sci')
exec('genqamdemod.sci')
clc;
M =4;
x =0:M-1;
y = oqpskmod(x)
disp(y,'QPSK modulated output=')
z = oqpskdemod(y)
disp(z,'QPSK demodulated output=')
//RESULT
//QPSK modulated output=   
//column 1 to 2
//0.7071068    0.7071068 + 0.7071068i  
//column 3 to 4
//0.7071068 + 0.7071068i    0.7071068 - 0.7071068i  
//column 5 to 6
//- 0.7071068 - 0.7071068i  - 0.7071068 + 0.7071068i  
//column 7 to 8
//- 0.7071068 + 0.7071068i  - 0.7071068 - 0.7071068i  
//column 9
// - 0.7071068i  
//QPSK demodulated output=   
//   0.    1.    2.    3. 
