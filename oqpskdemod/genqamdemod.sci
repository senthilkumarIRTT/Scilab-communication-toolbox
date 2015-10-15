function z = genqamdemod(y,const)
//GENQAMDEMOD General quadrature amplitude demodulation.
//WARNING: This is an obsolete function and may be removed in the future.
//        Please use comm.GeneralQAMDemodulator System object instead.
//   Z = GENQAMDEMOD(Y,CONST) demodulates the complex envelope Y of a
//  quadrature amplitude modulated signal. CONST is a one dimensional
//  vector that specifies the signal mapping. For two-dimensional signals,
//  the function treats each column as 1 channel.
// error checks
[ll,rr]=argn(0);
funcprot(0);
if(rr>2)
    error('comm:genqamdemod:numarg');
end
if(~(type(y)==[1 5 8]))
    error('comm:genqamdemod:Ynum');
end
// check that const is a 1-D vector
if(~isvector(const)|~(type(const)==[1 5 8]))
    error('comm:genqamdemod:const1D');
end
// --- Assure that Y, if one dimensional, has the correct orientation --- %
wid = size(y,1);
if(wid ==1)
    y = y(:);
end
[m,n]=size(y)
z = zeros(m,n);
disp(z)
disp(size(y,1))
disp(size(y,2))
for(i = 1:size(y,1)) 
    for(j = 1:size(y,2))
        //compute the minimum distance for each symbol
        [tmp, idx] = min(abs(y(i,j) - const));
        z(i,j) = idx-1;
    end
end
// --- restore the output signal to the original orientation --- %
if(wid == 1)
    z = z';
end
endfunction
