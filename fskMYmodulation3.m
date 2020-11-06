% https://www.allaboutcircuits.com/technical-articles/digital-signal-processing-in-scilab-how-to-decode-an-fsk-signal/
% mducng, SoC team, G2touch
% For MPP2.0 Ring pressure
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
receivedSignal   = [SymbolOne SymbolZero SymbolZero SymbolOne SymbolZero ...
    SymbolOne SymbolOne SymbolZero]; 
tRx              = (0:length(receivedSignal)-1)*1/Fs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DecodingZero     = receivedSignal .* [SymbolZero SymbolZero SymbolZero ...
    SymbolZero SymbolZero SymbolZero SymbolZero SymbolZero];
DecodingOne      = receivedSignal .* [SymbolOne  SymbolOne  SymbolOne  ...
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(4,2,1);
plot(t, SymbolZero);
axis([-1000*1/Fs 5000*1/Fs -0.5 4.5]);
xlabel('Symbol of bit zero.');

subplot(4,2,2);
plot(t, SymbolOne);
axis([-1000*1/Fs 5000*1/Fs -0.5 4.5]);
xlabel('Symbol of bit one.');

subplot(4,2,3);
plot(tRx,receivedSignal);
axis([-1000*1/Fs 5000*1/Fs -0.5 4.5]);
xlabel('Assumed a received message for 8 bits: 10010110.');

subplot(4,2,5);
plot(tRx,DecodingZero);
axis([-1000*1/Fs 5000*1/Fs -0.5 4.5]);
xlabel("Decoding zero.");

subplot(4,2,6);
plot(tRx,DecodingOne);
xlabel("Decoding one.");
axis([-1000*1/Fs 5000*1/Fs -0.5 4.5]);

subplot(4,2,7);
plot(tRx,SymbolOffsets_Zero)
xlabel("Offset zero calculation.");
axis([-1000*1/Fs 5000*1/Fs -0.5 4.5]);

subplot(4,2,8);
plot(tRx,SymbolOffsets_One)
xlabel("Offset one calculation.");
axis([-1000*1/Fs 5000*1/Fs -0.5 4.5]);
