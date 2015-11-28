function[C]=bitshift(A,K,varargin)
    //BITSHIFT Bit-wise shift.
//   C = BITSHIFT(A,K) returns the value of A shifted to the left by K bits, 
//   where A is a signed or unsigned integer array. Shifting by K bits
//   is the same as multiplication by 2^K. Negative values of K are allowed 
//   and this corresponds to shifting to the right, or dividing by 2^ABS(K) 
//   and rounding to the nearest integer towards negative infinity.
//   C = BITSHIFT(A,K,ASSUMEDTYPE) assumes A is of type ASSUMEDTYPE. If A
//   is a double array, then ASSUMEDTYPE can be 'int8', 'uint8', 'int16', 
//   'uint16', 'int32', 'uint32', 'int64', or 'uint64' (the default).
[ll,rr]= argn(0);
funcprot(0);
if rr<2 then
    error('comm:bitshift:numarg1');
end
if rr>4 then
    error('comm:bitshift:numarg2');
end
ASSUMEDTYPE = [];
if rr==3 then
    ASSUMEDTYPE = varargin(1)
end
    
    if (isempty(ASSUMEDTYPE))
        A = uint8(A);
        if(K<0)
            A =A/(2^abs(K));
        else
            A = A*(2^K);
        end
    else
        if (ASSUMEDTYPE=='uint8')
            A = uint8(A);
            if(K<0)
                A =A/(2^abs(K));
            else
                A = A*(2^K);
            end
           A= double(A);
       elseif(ASSUMEDTYPE=='int8')
           A = int8(A);
           if(K<0)
                A =A/(2^abs(K));
            else
                A = A*(2^K);
            end
            A = double(A);
        end
    end
    C =A;
endfunction
