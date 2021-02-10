%mducng/SoC/D2/G2touch
clc;
clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs                  =  1000000;                 % Sampling freq
dt                  =  1/Fs;
fP1                 =  20050;                   % Base freq
fP2                 =  20031;                   % Base freq
sps                 =  1281;                    % # samples per symbol
ns                  =  0:(sps-1);               % Samples vectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SymbolPressure1     =  sin(2*pi*ns*(fP1)*dt);
SymbolPressure2     =  sin(2*pi*ns*(fP2)*dt);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tS                  =  (0:length(SymbolPressure1)-1)*dt;  %t received symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nfft                =  1024;
dF                  =  Fs/Nfft;
fVectors            =  (0:(Nfft-1))*dF;
tVectors            =  (0:(Nfft-1))*dt;
FFTresult1          =  fft(SymbolPressure1,Nfft);
yAbs1               =  abs(FFTresult1);
yPhase1             =  imag(FFTresult1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot(4,1,1);
stem(tS,SymbolPressure1,':diamondr');
xlabel("256 pressure level.");
%axis([0 Nfft*1/Fs -2 2]);
%%%%%%%%%%%%%%
subplot(4,1,2);
stem(tVectors,SymbolPressure1(1:Nfft),':diamondr');
xlabel("256 pressure level.");
axis([0 Nfft*1/Fs -2 2]);
%%%%%%%%%%%%%%
subplot(4,1,3);
stem(fVectors,yAbs1);
title('Fourier transform. Abs.'); 
axis([0 Fs 0 Nfft/2]);
%%%%%%%%%%%%%%
subplot(4,1,4);
stem(fVectors,yPhase1);
title('Fourier transform. Abs.'); 
axis([0 Fs -Nfft Nfft/2]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sample-rate conversion: Fsnew = Fs/ss
ss                  = 16;
Nfftnew             = 8192;
Fsnew               = Fs/ss;
dtnew               = 1/Fsnew;
dFnew               = Fsnew/Nfftnew;
spsnew              = sps/ss;
for i = 1:1:Nfftnew  
    SymbolNew1(i)   = 0;
end
for i = 0:1:spsnew-1  
    SymbolNew1(i+1) = SymbolPressure1(ss*i+1);
end
%%%%%%
for i = 1:1:Nfftnew  
    SymbolNew2(i)   = 0;
end
for i = 0:1:spsnew-1  
    SymbolNew2(i+1) = SymbolPressure2(ss*i+1);
end
tSnew               = (0:length(SymbolNew1)-1)*dtnew;  %t received symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(4,1,1);
stem(tSnew,SymbolNew1,':diamondr');
xlabel("256 pressure level.");
%axis([0 Nfft*1/Fsnew -2 2]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fVectorsnew         = (0:(Nfftnew-1))*dFnew;
tVectorsnew         = (0:(Nfftnew-1))*dtnew;
FFTresult1new       = fft(SymbolNew1,Nfftnew);
FFTresult2new       = fft(SymbolNew2,Nfftnew);
yAbs1new            = abs(FFTresult1new);
yAbs2new            = abs(FFTresult2new);
yPhase1new          = imag(FFTresult1new);
yPhase2new          = imag(FFTresult2new);
%%%%%%%%%%%%%%
subplot(4,1,2);
plot(tVectorsnew,SymbolNew1(1:Nfftnew),tVectorsnew,SymbolNew2(1:Nfftnew));
xlabel("256 pressure level.");
axis([0 Nfftnew*dtnew -2 2]);
%%%%%%%%%%%%%%
subplot(4,1,3);
plot(fVectorsnew,yAbs1new,fVectorsnew,yAbs2new);
title('Fourier transform. Abs.'); 
axis([0 Fsnew 0 Nfftnew/64]);
%%%%%%%%%%%%%%
subplot(4,1,4);
plot(fVectorsnew,yPhase1new,fVectorsnew,yPhase2new);
title('Fourier transform. Abs.'); 
axis([0 Fsnew -Nfftnew/64 Nfftnew/64]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If we feel the power of symbol is small, we can expand like:
% [A,0,0,0,...] --> [A,A,A,A,...]
%