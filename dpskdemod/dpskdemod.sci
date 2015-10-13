function z = dpskdemod(y,M,varargin)
// DPSKDEMOD Differential phase shift keying demodulation.
//WARNING: This is an obsolete function and may be removed in the future.
//        Please use comm.DPSKDemodulator System object instead.
//  Z = DPSKDEMOD(Y,M) demodulates the complex envelope Y of a DPSK
//  modulated signal. M is the alphabet size and must be an integer. For
//  two-dimensional signals, the function treats each column as 1 channel.
//   Z = DPSKDEMOD(Y,M,PHASEROT) specifies the phase rotation (rad). In this
//  case, the total per-symbol phase shift is the sum of PHASEROT and the
// phase generated by the differential modulation.
//   Z = DPSKDEMOD(X,M,PHASEROT,SYMBOL_ORDER) specifies how the function 
//  assigns binary words to corresponding integers. If SYMBOL_ORDER is set 
//   to 'bin' (default), then the function uses a natural binary-coded ordering.  
//   If SYMBOL_ORDER is set to 'gray', then the function uses a Gray-coded ordering.

// error checks
[ll,rr]=argn(0);
funcprot(0);
if(rr<2)
    error('comm:dpskdemod:numarg1');
end
if(rr>4)
    error('comm:dpskdemod:numarg2');
end
//Check y, phase, Symbol set ordering
if( ~or(type(y)==[1 5 8]))
    error('comm:dpskdemod:Ynum');
end
if(~isreal(M)|~isscalar(M)|M<=0|(ceil(M)~=M)|~or(type(M)==[1 5 8]))
    error('comm:dpskdemod:Mreal');
end
if(rr==2|isempty(varargin(1)))    
   Phase_Rotation = 0;
else
    Phase_Rotation = varargin(1);
    if(~isreal(Phase_Rotation)|~isscalar(Phase_Rotation)|~or(type(Phase_Rotation)==[1 5 8]))
        error('comm:dpskdemod:phaserotReal');    
    end
    // Map phase rotation to (-pi, pi]
    Phase_Rotation = modulo(Phase_Rotation,2*%pi);
    if(Phase_Rotation>%pi)
        Phase_Rotation = Phase_Rotation - 2*%pi;
    end
end
// Check SYMBOL_ORDER
if(rr==2|rr==3)    
   Symbol_Ordering = 'bin'; // default
else
    Symbol_Ordering = varargin(2);
    if(~(type(Symbol_Ordering)=10))|(~strcmpi(Symbol_Ordering,'GRAY'))&(~strcmpi(Symbol_Ordering,'BIN'))
        error('comm:dpskdemod:SymbolOrder');    
    end
end
// --- Assure that Y, if one dimensional, has the correct orientation --- %
wid = size(y,1);
if(wid ==1)
    y = y(:);
end
// Normalization factor to convert from PI domain to linear domain
Norm_Factor = M/(2*%pi);
// Calculate the phase difference
for i = 1:length(y)
    angle(i)=atan(imag(y(i)),real(y(i)))
end
zPi = diff(unwrap([zeros(1,size(y, 2));angle]))- Phase_Rotation;
// Convert zPi to linear domain; and make hard decisions by rounding to the
//nearest integer
// Note: To be consistent with the blocks, we map 0.5 to 0
z = ceil(zPi*Norm_Factor - 0.5);
// Remap to 0:M-1
z(z < 0) = M + z(z < 0);
// --- restore the output signal to the original orientation --- %
if(wid == 1)
    z = z';
end
// Gray decode if necessary
if(Symbol_Ordering=='GRAY')
    // DPSK's first element differs, In case of a rectangular
    // matrix the columns are interpreted as independent
    // column vectors (similar to frames in Simulink) with different
    // first elements
    [z_degray,gray_map] = gray2bin(z,'DPSK',M);   //Gray decode
    z = gray_map(z+1);    
end
// [EOF]
endfunction