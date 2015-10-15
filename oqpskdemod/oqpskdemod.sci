function z = oqpskdemod(y,varargin)
// OQPSKDEMOD Offset quadrature phase shift keying demodulation.
//   Z = OQPSKDEMOD(Y) demodulates the complex envelope Y of an OQPSK
//   modulated signal. For two-dimensional signals, the function treats
//   each column as 1 channel. This function implicitly downsamples by a
//   factor of 2, because an odd number of samples per symbol is not allowed
//   for OQPSK.
//   Z = OQPSKDEMOD(Y,INI_PHASE) specifies the phase offset (rad) of the
//  modulated signal.
// error checks
[ll,rr]=argn(0);
funcprot(0);
if(rr>2)
    error('comm:oqpskdemod:numarg');
end
//Check y, ini_phase
if( ~(type(y)=[1 5 8]))
    error('comm:oqpskdemod:Ynum');
end

Nsamp = 2;
if(rr==1|isempty(varargin))    
    ini_phase = 0;
else
    ini_phase = varargin(1);
    if(~isreal(ini_phase)| ~isscalar(ini_phase)| ~(type(ini_phase)=[1 5 8]) )
        error('comm:oqpskdemod:ini_phaseReal');    
    end
end
// --- Assure that Y, if one dimensional, has the correct orientation --- %
wid = size(y,1);
if(wid ==1)
    y = y(:);
end
// separate the signal into I and Q
yI = real(y);
yQ = imag(y);

//remove offset 
yQ = yQ(2:$,:);
yI = yI(1:$-1,:);

//create non-offset signal
y = yI + %i*yQ;

//create the modmap
modmap = zeros(1,4);
modmap(1) = cos(ini_phase + %pi/4) + %i* sin(ini_phase + %pi/4);
modmap(2) = cos(ini_phase + 7*%pi/4) + %i * sin(ini_phase + 7*%pi/4);
modmap(3) = cos(ini_phase + 3*%pi/4) +%i * sin(ini_phase + 3*%pi/4);
modmap(4) = cos(ini_phase + 5*%pi/4) + %i * sin(ini_phase + 5*%pi/4);

//integrate.
y = intdump(y,Nsamp);
disp(y)

z = genqamdemod(y,modmap);
disp(z)

//--- restore the output signal to the original orientation --- 
if(wid == 1)
    z = z';
end
endfunction
