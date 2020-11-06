% https://www.allaboutcircuits.com/technical-articles/digital-signal-processing-in-scilab-how-to-decode-an-fsk-signal/
% mducng, SoC team, G2touch
% For MPP2.0 Amplitude comparison by DC offset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;
close all;
f0               =  76500;
f1               =  85400;
Fs               =  4000000;
SamplesPerSymbol =  142*4; % 142*10^(-6)*Fs = 142*4 (142 is from spec)
n                = 0:(SamplesPerSymbol-1);
t                = n*1/Fs;
SymbolZero       = 1 + sin(2*pi*f0*t);
SymbolOne        = 1 + sin(2*pi*f1*t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Signal 1:
receivedSignal1   = 4*[SymbolOne SymbolZero SymbolZero SymbolOne SymbolZero ...
    SymbolOne SymbolOne SymbolZero]; 
tRx              = (0:length(receivedSignal1)-1)*1/Fs;
% Signal 2
receivedSignal2   = 2+1*[SymbolOne SymbolZero SymbolZero SymbolOne ...
    SymbolZero SymbolOne SymbolOne SymbolZero]; 
tRx2              = (0:length(receivedSignal2)-1)*1/Fs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DecodingZero     = receivedSignal1 .* [SymbolZero SymbolZero SymbolZero ...
    SymbolZero SymbolZero SymbolZero SymbolZero SymbolZero];
DecodingOne      = receivedSignal1 .* [SymbolOne  SymbolOne  SymbolOne  ...
    SymbolOne  SymbolOne  SymbolOne  SymbolOne  SymbolOne ];

DecodingZero2     = receivedSignal2 .* [SymbolZero SymbolZero SymbolZero ...
    SymbolZero SymbolZero SymbolZero SymbolZero SymbolZero];
DecodingOne2      = receivedSignal2 .* [SymbolOne  SymbolOne  SymbolOne  ...
    SymbolOne  SymbolOne  SymbolOne  SymbolOne  SymbolOne ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:(length(DecodingZero)/SamplesPerSymbol)
    SymbolOffsets_Zero((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol))	...
        = mean(DecodingZero((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)));
end
for k=1:(length(DecodingOne)/SamplesPerSymbol)
    SymbolOffsets_One((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)) 	...
        = mean(DecodingOne((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)));
end
for k=1:(length(DecodingZero2)/SamplesPerSymbol)
    SymbolOffsets_Zero(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol))	...
        = mean(DecodingZero2(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol)));
end
for k=1:(length(DecodingOne2)/SamplesPerSymbol)
    SymbolOffsets_One(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol)) 	...
        = mean(DecodingOne2(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%subplot(7,2,1);
%plot(t, SymbolZero);
%axis([-1000*1/Fs 5000*1/Fs -5 5]);
%xlabel('Modulation of bit zero.');

%subplot(7,2,3);
%plot(t, SymbolOne);
%axis([-1000*1/Fs 5000*1/Fs -5 5]);
%xlabel('Modulation of bit one.');

subplot(5,2,1);
plot(tRx,receivedSignal1);
axis([-1000*1/Fs 5000*1/Fs -2 20]);
xlabel('Assumed a received signal for 8 bits: 10010110.');

subplot(5,2,3);
plot(tRx,DecodingZero);
axis([-1000*1/Fs 5000*1/Fs -2 20]);
xlabel("Decoding zero.");

subplot(5,2,5);
plot(tRx,DecodingOne);
xlabel("Decoding one.");
axis([-1000*1/Fs 5000*1/Fs -2 20]);

subplot(5,2,7);
plot(tRx,SymbolOffsets_Zero)
xlabel("Offset zero calculation.");
axis([-1000*1/Fs 5000*1/Fs -2 20]);

subplot(5,2,9);
plot(tRx,SymbolOffsets_One)
xlabel("Offset one calculation.");
axis([-1000*1/Fs 5000*1/Fs -2 20]);

subplot(5,2,2);
plot(tRx2,receivedSignal2);
axis([-1000*1/Fs 5000*1/Fs -2 20]);
xlabel('Assumed a received signal for 8 bits: 10010110.');

subplot(5,2,4);
plot(tRx2,DecodingZero2);
axis([-1000*1/Fs 5000*1/Fs -2 20]);
xlabel("Decoding zero.");

subplot(5,2,6);
plot(tRx2,DecodingOne2);
xlabel("Decoding one.");
axis([-1000*1/Fs 5000*1/Fs -2 20]);

subplot(5,2,8);
plot(tRx2,SymbolOffsets_Zero)
xlabel("Offset zero calculation.");
axis([-1000*1/Fs 5000*1/Fs -2 20]);

subplot(5,2,10);
plot(tRx2,SymbolOffsets_One)
xlabel("Offset one calculation.");
axis([-1000*1/Fs 5000*1/Fs -2 20]);
