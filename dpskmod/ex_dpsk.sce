clear;
clc;
bk = input('Enter the input data sequence =');
initial_bit = input('Enter initial bit binary one or zero =');
exec('dpsk.sci')
exec('dpskdecod.sci')
[dk,dk_radians]=dpskmod(bk);
bk_out = dpskdecod(initial_bit,dk_radians)
//Example 1
//Enter the input data sequence =[1 0 0 1 0 0 1 1]
//Enter initial bit binary one or zero =1
//DPSK input sequence bk=   1.    0.    0.    1.    0.    0.    1.    1.  
//Complement of DPSK input sequence bk_not= 0.    1.    1.    0.    1.    1.    0.    0.  
//Differentially encoded sequence dk= 1.    0.    1.    1.    0.    1.    1.    1.  
//Transmitted phase in radians dk_radians= 0.    3.1415927    0.    0.    3.1415927    0.    0.    0. 

//Example 2 
//Enter the input data sequence =[1 0 0 1 0 0 1 1]
//Enter initial bit binary one or zero =0
//DPSK input sequence bk=   1.    0.    0.    1.    0.    0.    1.    1.
//Complement of DPSK input sequence bk_not=  0.    1.    1.    0.    1.    1.    0.    0.  
//Differentially encoded sequence dk=   0.    1.    0.    0.    1.    0.    0.    0. 
//Transmitted phase in radians dk_radians= 3.1415927    0.    3.1415927    3.1415927    0.    3.1415927  3.1415927    3.1415927  
