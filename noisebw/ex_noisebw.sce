clear;
close;
clc;
Fs = 16; // Sampling rate
Fnyq = Fs/2; // Nyquist frequency
Fc = 0.5; // Carrier frequency
//[num,den] = butter(2,Fc/Fnyq) % Butterworth filter
//num =[0.0084,0.0169,0.0084];
//den =[1.0000,-1.7238,0.7575];
Hz = iir(2,'lp','butt',[Fc/(2*Fnyq),0],[0,0]);
num = coeff(Hz(2));
den = coeff(Hz(3));
den = den([$:-1:1]);
exec('noisebw.sci')
bw = noisebw(num,den,100,Fs)
disp(bw,'Noise Bandwidth=')
