clear;
close;
clc;
exec('dpskmod.sci')
exec('bin2gray.sci')
exec('gray2bin.sci')
exec('dpskdemod.sci')
clc;
M = input('Enter the alphabet size =');
x = 0:M-1;
//Example 1: 
//y = dpskmod(x,M)
//Example 2:
//y = dpskmod(x,M,%pi/8)
//Example 3: 
y = dpskmod(x,M,%pi/8,'GRAY')
disp(y,'DPSK modulated output=')
a = gca();
plot(real(y),imag(y))
a.data_bounds = [-1,-1;1,1]
/////////////////////////////////

//Example 1:
//z = dpskdemod(y,M)
//Example 2:
//z = dpskdemod(y,M,%pi/8)
//Example 3:
z = dpskdemod(y,M,%pi/8,'GRAY')
disp(z,'DPSK demodulated output=')
/////////////////////////////////////////////////////
//RESULT
//Example 1
//DPSK modulated output=   
// column 1 to 3
// 1.    6.123D-17 + i    - 1.837D-16 - i    
// column 4
//  - 1. + 3.674D-16i  
// DPSK demodulated output=   
//   0.    1.    2.    3. 
//Example 2
//DPSK modulated output=   
//column 1 to 2
//0.9238795 + 0.3826834i  - 0.7071068 + 0.7071068i  
//column 3 to 4
//0.9238795 - 0.3826834i  - 4.286D-16 - i    
//DPSK demodulated output=   
//0.    1.    2.    3.  
//Example 3
//DPSK modulated output=   
// 
// 
//         column 1 to 2
// 
//    0.9238795 + 0.3826834i  - 0.7071068 + 0.7071068i  
// 
//         column 3 to 4
// 
//    0.3826834 + 0.9238795i  - 4.286D-16 - i   
//DPSK demodulated output=   
// 
//    0.  
//    1.  
//    2.  
//    3.  
//
