% https://www.allaboutcircuits.com/technical-articles/digital-signal-processing-in-scilab-how-to-decode-an-fsk-signal/
% mducng, SoC team, G2touch
% For MPP2.0: 256 pressure level by DC offset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;
close all;
fbase            =  18379;
f1               =  21433;
Fs               =  4000000;
SamplesPerSymbol =  1282*4; % 142*10^(-6)*Fs = 142*4 (142 is from spec)
n                =  0:(SamplesPerSymbol-1);
t                =  n*1/Fs;
SymbolBase       =  (1+cos(2*pi*fbase*t));
SignalBase       =  1+cos(2*pi*fbase*t);
SignalOne        =  1+cos(2*pi*f1*t);
tRx              =  (0:length(SignalOne)-1)*1/Fs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DecodingZero     =  SignalBase .* SymbolBase;
DecodingOne      =  SignalOne .* SymbolBase;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:(length(DecodingZero)/SamplesPerSymbol)
    SymbolOffsets_Zero((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol))	= ...
        mean(DecodingZero((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)));
end
for k=1:(length(DecodingZero)/SamplesPerSymbol)
    SymbolOffsets_One((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol))	= ...
        mean(DecodingOne((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure;

subplot(5,1,1);
plot(t, SignalBase);
axis([-1000*1/Fs 7000*1/Fs -1 5]);
xlabel('Signal of frequency base.');

subplot(5,1,2);
plot(t, SignalOne);
axis([-1000*1/Fs 7000*1/Fs -1 5]);
xlabel('Signal of frequency one.');

subplot(5,1,3);
plot(tRx,DecodingZero);
axis([-1000*1/Fs 7000*1/Fs -1 5]);
xlabel("Decoding of signal BASE.");

subplot(5,1,4);
plot(tRx,DecodingOne);
axis([-1000*1/Fs 7000*1/Fs -1 5]);
xlabel("Decoding of signal ONE.");

subplot(5,1,5);
plot(tRx,SymbolOffsets_Zero,tRx,SymbolOffsets_One)
axis([-1000*1/Fs 7000*1/Fs -1 5]);
xlabel("Offset calculation.");

%subplot(2,1,2);
%plot(tRx,SymbolOffsets_One)
%axis([-1000*1/Fs 7000*1/Fs -100 6000]);
%xlabel("Offset One calculation.");
