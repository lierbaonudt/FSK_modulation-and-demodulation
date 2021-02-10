%mducng/SoC/D2/G2touch
clc;
clear;
close all;
% to test the Fs conversion: 1MHz --> 125kHz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs                  =  1000000;                 % Sampling freq 1MHz
dt                  =  1/Fs;
fP                  =  20050;                   % Base freq
sps                 =  1281;                    % #samples per symbol
ns                  =  0:(sps-1);               % Samples vectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SymbolPressure1     =  sin(2*pi*ns*fP*dt);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tS                  = (0:length(SymbolPressure1)-1)*dt;  %t received symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nfft                = 1024;
dF                  = Fs/Nfft;
fVectors            = (0:(Nfft-1))*dF;
tVectors            = (0:(Nfft-1))*dt;
FFTresult1          = fft(SymbolPressure1,Nfft);
yAbs1               = abs(FFTresult1/Nfft);
%yPhase1             = imag(FFTresult1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot(3,1,1);
stem(tS,SymbolPressure1,':diamondr');
xlabel("256 pressure level.");
%axis([0 Nfft*1/Fs -2 2]);
%%%%%%%%%%%%%%
subplot(3,1,2);
stem(tVectors,SymbolPressure1(1:Nfft),':diamondr');
xlabel("256 pressure level.");
%axis([0 Nfft*1/Fs -2 2]);
%%%%%%%%%%%%%%
subplot(3,1,3);
stem(fVectors,yAbs1);
title('Fourier transform. Abs.'); 
%axis([0 Fs 0 Nfft/2]);
%%%%%%%%%%%%%%
%subplot(4,1,4);
%stem(fVectors,yPhase1);
%title('Fourier transform. Abs.'); 
%axis([0 Fs -Nfft Nfft/2]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sample-rate conversion Fsnew = Fs/ss
ss                  = 8;
Nfftnew             = 8192;
Fsnew               = Fs/ss;
dtnew               = 1/Fsnew;
dFnew               = Fsnew/Nfftnew;
spsnew              = sps/ss;
SymbolNew           = SymbolPressure1(1:ss:sps);
tSnew               = (0:length(SymbolNew)-1)*dtnew;  %t received symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(3,1,1);
stem(tSnew,SymbolNew,':diamondr');
xlabel("256 pressure level.");
%axis([0 Nfft*1/Fsnew -2 2]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:1:Nfftnew  
    SymbolNew(i)    = 0;
end
for i = 1:1:spsnew  
    SymbolNew(i)    = SymbolPressure1(ss*i);
end
tSnew               = (0:length(SymbolNew)-1)*dtnew;  %t received symbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fVectorsnew         = (0:(Nfftnew-1))*dFnew;
tVectorsnew         = (0:(Nfftnew-1))*dtnew;
FFTresult1new       = fft(SymbolNew,Nfftnew);
yAbs1new            = abs(FFTresult1new);
%yPhase1new          = imag(FFTresult1new);
%%%%%%%%%%%%%%
subplot(3,1,2);
stem(tVectorsnew,SymbolNew,':diamondr');
xlabel("256 pressure level.");
%axis([0 Nfftnew*dtnew -2 2]);
%%%%%%%%%%%%%%
subplot(3,1,3);
stem(fVectorsnew,yAbs1new);
title('Fourier transform. Abs.'); 
%axis([0 Fsnew 0 Nfftnew/64]);
%%%%%%%%%%%%%%
%subplot(4,1,4);
%stem(fVectorsnew,yPhase1new);
%title('Fourier transform. Abs.'); 
%axis([0 Fsnew -Nfftnew/64 Nfftnew/64]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   