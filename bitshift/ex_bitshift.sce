clear
clc
//Example 1
a = 255; //intmax('uint8');
s1 = 'Initial uint8 value %5d is %08s in binary\n';
s2 = 'Shifted uint8 value %5d is %08s in binary\n';
disp(dec2bin(a))
exec('bitshift.sci')
 for i = 1:8
    a = bitshift(a,1);
    disp(s2)
    disp(a)
    disp(dec2bin(a))
 end
 
 //Example 2
uintout = bitshift(6,5:7,'uint8')
disp(uintout)


//Example 3
intout = bitshift(6,5:7,'int8')
disp(intout)
