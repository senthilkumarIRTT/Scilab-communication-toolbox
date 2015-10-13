clear;
clc;
M = input('Modulation order or level=');
x=0:M-1;
modulation =input('Enter the type of modulation like=' )
//Modulation may be 'PSK','FSK','DPSK','PAP','QAM'
exec('bin2gray.sci');
exec('gray2bin.sci');
clc;
[y,map1] = bin2gray(x,modulation,M);
[z,map2] = gray2bin(y,modulation,M);
disp(y,'Gray Encoded Output=')
disp(z,'Gray Decoded Output=')
//RESULT 
//Example 1
//Modulation order or level=16
//Enter the type of modulation like='PSK'
// Gray Encoded Output=   
//   0  1  3  2  6  7  5  4  12  13  15  14  10  11  9  8  
// Gray Decoded Output=   
//    column  1 to 12
//    0.    1.    2.    3.    4.    5.    6.    7.    8.    9.    10.    11.  
//    column 13 to 16
//    12.    13.    14.    15.  
 //Example 2
// Modulation order or level=16
//Enter the type of modulation like='QAM'
// Gray Encoded Output=   
// column  1 to 12
// 0.    1.    3.    2.    4.    5.    7.    6.    12.    13.    15.    14.  
// column 13 to 16
// 8.    9.    11.    10.  
// Gray Decoded Output=   
// column  1 to 12
// 0.    1.    2.    3.    4.    5.    6.    7.    8.    9.    10.    11.  
// column 13 to 16
// 12.    13.    14.    15.  
