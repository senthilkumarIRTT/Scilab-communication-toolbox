function y = genqammod(x,const)
//GENQAMMOD General quadrature amplitude modulation
//   Y = GENQAMMOD(X,CONST) outputs the complex envelope of the modulation
//  of the message signal X using quadrature amplitude modulation.  The
//  message signal must consist of integers between 0 and 1 less than the
//  length of CONST. CONST is a one dimensional vector that specifies the
//  signal mapping. For two-dimensional signals, the function treats each
//  column as 1 channel.
//Check x,Nsamp, const.
if ( ~isreal(x) | or(or(ceil(x)~=x)) | ~(type(x)==[1 5 10] ) )
    error('comm:genqammod:Xreal');
end
//Determine the size of M
M = max(size(const));
// check that X are all integers within range.
if (min(min(x)) < 0)  | (max(max(x)) > (M-1))
    error('comm:genqammod:Xreal');
end
// check that const is a 1-D vector
if(~isvector(const) | ~(type(const)==[1 5 8] ))
    error('comm:genqammod:const1d');
end
// --- Assure that X, if one dimensional, has the correct orientation --- %
wid = size(x,1);
if(wid ==1)
    x = x(:);
end
// --- constellation needs to have the same orientation as the input -- %
if(size(const,1) ~= size(x,1) )
    const = const(:);
end
// map
y = const(x+1);

//ensure output is a complex data type
y = complex(real(y),imag(y));

//--- restore the output signal to the original orientation --- %
if(wid == 1)
    y = y.';
end
// --- EOF --- %
endfunction
