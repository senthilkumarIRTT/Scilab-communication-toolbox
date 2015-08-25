function[dk,dk_radians]= dpskmod(bk,initial_bit)
//bk -input digital sequence
//dk-differential phase shift key encoded sequence
//dk_radians-dpsk output transmitted phase sequence
for i = 1:length(bk)
  if(bk(i)==1)
    bk_not(i) =~1;
  else
    bk_not(i)= 1;
  end
end
dk_1(1) = initial_bit&bk(1);  //initial value of differential encoded sequence
initial_bit_not = ~initial_bit;
dk_1_not(1)=initial_bit_not&bk_not(1);
dk(1) = xor(dk_1(1),dk_1_not(1))//first bit of dpsk encoder
for i=2:length(bk)
  dk_1(i) = dk(i-1);
  dk_1_not(i) = ~dk(i-1);
  dk(i) = xor((dk_1(i)&bk(i)),(dk_1_not(i)&bk_not(i)));
end
for i =1:length(dk)
  if(dk(i)==1)
    dk_radians(i)=0;
  elseif(dk(i)==0)
    dk_radians(i)=%pi;
  end
end
disp(bk,'DPSK input sequence bk=')
bk_not = bk_not';
disp(bk_not,'Complement of DPSK input sequence bk_not=')
dk = dk';
disp(dk,'Differentially encoded sequence dk=')
dk_radians = dk_radians';
disp(dk_radians,'Transmitted phase in radians dk_radians=')
endfunction
//////////////////////////////////////////////////////////
//function for XOR gate
function [value] = xor(A,B)
  if(A==B)
    value = 0;
  else
    value = 1;
  end
endfunction
