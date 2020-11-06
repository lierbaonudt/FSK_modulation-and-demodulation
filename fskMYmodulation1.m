%https://www.allaboutcircuits.com/technical-articles/digital-signal-processing-in-scilab-how-to-decode-an-fsk-signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
close all;
f0               =  10000;
f1               =  30000;
Fs               =  300000;
SamplesPerSymbol =  50;
n                =  0:(SamplesPerSymbol-1);
SymbolZero       =  sin(2*pi*n*f0/Fs);
SymbolOne        =  sin(2*pi*n*f1/Fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
receivedSignal   = [SymbolOne SymbolZero SymbolOne  SymbolZero]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllZerosSymbols  = [SymbolZero SymbolZero SymbolZero SymbolZero];
AllOnesSymbols   = [SymbolOne SymbolOne SymbolOne SymbolOne];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DecodingZero     = receivedSignal .* AllZerosSymbols;
DecodingOne      = receivedSignal .* AllOnesSymbols;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:(length(DecodingZero)/SamplesPerSymbol)
    SymbolOffsets_Zero(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol))...
        = mean(DecodingZero(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol)));
end
for k=1:(length(DecodingOne)/SamplesPerSymbol)
    SymbolOffsets_One(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol))...
        = mean(DecodingOne(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tRx            = (0:length(receivedSignal)-1)*1/Fs;

subplot(7,1,1);
plot(tRx,receivedSignal)
xlabel("Mixed signal.");
axis([0*1/Fs 300*1/Fs -2 2]);

subplot(7,1,2);
plot(tRx,AllZerosSymbols)
xlabel("All frequency Zeros symbols.");
axis([0*1/Fs 300*1/Fs -2 2]);

subplot(7,1,3);
plot(tRx,AllOnesSymbols)
xlabel("All frequency Ones symbols.");
axis([0*1/Fs 300*1/Fs -2 2]);

subplot(7,1,4);
plot(tRx,DecodingZero)
xlabel("DecodingZero symbols.");
axis([0*1/Fs 300*1/Fs -2 2]);

subplot(7,1,5);
plot(tRx,DecodingOne)
xlabel("DecodingOne symbols.");
axis([0*1/Fs 300*1/Fs -2 2]);

subplot(7,1,6);
plot(tRx,SymbolOffsets_Zero)
xlabel("SymbolOffsets_Zero symbols.");
axis([0*1/Fs 300*1/Fs -2 2]);

subplot(7,1,7);
plot(tRx,SymbolOffsets_One)
xlabel("SymbolOffsets_One symbols.");
axis([0*1/Fs 300*1/Fs -2 2]);