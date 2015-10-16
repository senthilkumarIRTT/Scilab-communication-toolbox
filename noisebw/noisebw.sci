function bw = noisebw(num,den,numSamp,Fs)
//NOISEBW Calculate the equivalent noise bandwidth of a digital lowpass filter.
//BW = NOISEBW(NUM, DEN, NUMSAMP, Fs) returns the two-sided equivalent noise
//bandwidth, in Hz, of a digital lowpass filter given in descending powers of z by
//numerator vector NUM and denominator vector DEN.  The bandwidth is calculated
//   over NUMSAMP samples of the impulse response.  Fs is the sampling rate of the
//   signal that the filter would process; this is used as a scaling factor to convert
//   a normalized unitless quantity into a bandwidth in Hz.
// Error checking --------------------------------------------------
//Total number of arguments
[ll,rr]=argn(0);
funcprot(0)
if (rr ~= 4)
    error('comm:noisebw:InvalidNumberOfArgs');
end

if (~(type(num)==[1 5 8])|isempty(num)|~isvector(num)|~isreal(num))
    error('comm:noisebw:Invalidnum')
end
if (~(type(den)==[1 5 8])|isempty(den)|~isvector(den)|~isreal(den))
    error('comm:noisebw:Invalidnum')
end

if (isempty(numSamp)|~isscalar(numSamp)|~(type(numSamp)==[1 5 8])|numSamp<=0)
    error('comm:noisebw:InvalidNumSamp');
end

if (isempty(Fs) | ~isscalar(Fs) | ~isreal(Fs) | ~(type(Fs)==[1 5 8]) | Fs<=0)
    error('comm:noisebw:InvalidFs');
end
// Check that the filter is lowpass by finding the -10 dB point, then by checking if
//any frequencies beyond that point have a filter magnitude greater than -10 dB
h = freq(num,den,numSamp);
//freq(num,den,numSamp)
hMag = 20 * log10(%eps+abs(h)./max(abs(h)));
startIndex = find(hMag <= -10,1 );
disp(startIndex)
disp(hMag)
for i = 1:length(hMag)
 if (hMag(i)< -10)
        error('comm:noisebw:InvalidFilter');
 end    
end
   
////End of error checking -----------------------------------------------

//Create the impulse
impulse = zeros(numSamp, 1);
impulse(1) = 1;

//Create the impulse response
response = filter(num,den,impulse);

//Calculate the noise bandwidth
numBW = cumsum(response .* conj(response));
numBW = numBW($) * Fs;
denBW = cumsum(response) .* cumsum(conj(response));
denBW = denBW($);

bw = numBW / denBW;
endfunction
