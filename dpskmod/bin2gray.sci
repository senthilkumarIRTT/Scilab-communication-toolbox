function [output,mapping] = bin2gray(x,modulation,order)
  //BIN2GRAY Gray encode
//Y = BIN2GRAY(X,MODULATION,M) generates a Gray encoded output with the same
//  dimensions as its input parameter X.  The input X can be a scalar, vector or
//  matrix.  MODULATION is the modulation type, which can be a string equal to
//  'QAM', 'PAM', 'FSK', 'DSPK' or 'PSK'.  M is the modulation order that must
//  be an integer power of two.
[ll,rr]=argn(0);
funcprot(0);
if rr<3 then
	error("Too few input arguments.");
end;
//Validate numeric x data
if isempty(x)
    error("comm:bin2gray:InputEmpty");
end
//x must be a scalar, vector or a 2D matrix
if length(size(x))>2
    error("comm:bin2gray:InputDimensions");
end
//Validate modulation type
if (~(type(modulation)==10))|(~strcmpi(modulation,'QAM'))&(~strcmpi(modulation,'PSK'))...
        &(~strcmpi(modulation,'FSK'))&(~strcmpi(modulation,'PAM'))&(~strcmpi(modulation,'DPSK'))
    error("comm:bin2gray:ModulationTypeError");
end
//Validate modulation order
if (order < 2)|(isinf(order)|...
        (~isreal(order))|(floor(log2(order)) ~= log2(order)))
    error("comm:bin2gray:ModulationOrderError");
end
//Check for overflows - when x is greater than the modulation order
if (max(max(x)) >= order)
    error("comm:bin2gray:XError");
end
if ((modulation == 'PSK')|(modulation == 'PAM')|(modulation == 'DPSK')|(modulation == 'FSK')) 
    y = uint8(1)
elseif(modulation=='QAM')
    y= uint8(0)
end
   select y

    case 1
    //'PSK', 'PAM','FSK','DSPK'
        // Calculate Gray table
        j = (0:order-1)';
        j = uint8(j)
        mapping = bitxor(j,bitshift(j,-1));
        // Format output and translate x (map) i.e. convert to Gray
        output = mapping(x+1);
        //Assure that the output, if one dimensional,
        //has the correct orientation
        wid = size(x,1);
        if(wid == 1)
            output = output';
        end
        mapping = mapping'
    case 0
        //QAM
        k = log2(order);                // Number of bits per symbol
        mapping = (0:order-1)';         // Binary mapping to be Gray converted
        if rem(k,2) // non-square constellation
            kI = (k+1)/2;
            kQ = (k-1)/2;
            symbolI = bitshift(mapping,-kQ);
            symbolQ = bitand(mapping,bitshift(order-1,-kI));
            // while i is smaller (Number of bits per symbol)/2
            i = 1;
            while i < kI
                tempI = symbolI;
                tempI = bitshift(tempI,-i);
                symbolI = bitxor(symbolI,tempI);
                i = i + i;                          // i takes on values 1,2,4,8,...,2^n - n is an integer
            end
            // while i is smaller (Number of bits per symbol)/2
            i = 1;
            while i < kQ
                tempQ = symbolQ;
                tempQ = bitshift(tempQ,-i);
                symbolQ = bitxor(symbolQ, tempQ);
                i = i + i;                          // i takes on values 1,2,4,8,...,2^n - n is an integer
            end
            SymbolIndex = double(bitshift(symbolI,kQ) + symbolQ);
        else         // square constellation
            symbolI = bitshift(mapping,-k/2);
            z = uint8(bitshift(order-1,-k/2)*ones(1,length(mapping)))
            symbolQ = bitand(uint8(mapping),z');
            // while i is smaller (Number of bits per symbol)/2
            i = 1;
            while i < k/2
                tempI = symbolI;
                tempI = bitshift(tempI,-i);
                symbolI = bitxor(symbolI,tempI);

                tempQ = symbolQ;
                tempQ = bitshift(tempQ,-i);
                symbolQ = bitxor(symbolQ, tempQ);
                i = i + i;                          // i takes on values 1,2,4,8,...,2^n - n is an integer
            end
            SymbolIndex = double(bitshift(symbolI,k/2) + symbolQ);
        end
        mapping = SymbolIndex;
        //Format output and translate x (map) i.e. convert to Gray
        output = mapping(x+1);
       //Assure that the output, if one dimensional,
        //has the correct orientation
        if or(size(x) ~= size(output))
            output = output';
        end
        //Make sure that mapping is a vector, when used to name the symbols
        //column-wise starting from left upper corner, results in a gray mapped
        //constellation.
       [dummy,index]=members(0:order-1,mapping);
        mapping = index - 1;
    else
        error("comm:bin2gray:ModulationTypeUnknown")
    end
endfunction
//-----------------------------------------------------------------------------------
function [Z] = rem(X,Y)
   Z=  X-fix(X./Y).*Y
endfunction
//---------------------------------------------------------------------------------
function[C]=bitshift(A,K)
    A = uint8(A);
    if(K<0)
        A =A/(2^abs(K));
    else
        A = A*(2^K);
    end
    C =A;
endfunction
//---------------------------------------------------------------------------------
