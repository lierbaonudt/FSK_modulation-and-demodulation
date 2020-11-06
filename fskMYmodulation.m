%https://www.allaboutcircuits.com/technical-articles/digital-signal-processing-in-scilab-how-to-decode-an-fsk-signal

clear;
close all;
f0               =  10000;
f1               =  15000;
Fs               =  300000;
SamplesPerSymbol =  50;

n                = 0:(SamplesPerSymbol-1);
SymbolZero       = sin(2*pi*n*f0/Fs);
SymbolOne        = sin(2*pi*n*f1/Fs);

subplot(4,2,1);
stem(n, SymbolZero);
axis([-10 250 -2 2]);
xlabel('symbol zero');

subplot(4,2,2);
stem(n, SymbolOne);
axis([-10 500 -2 2]);
xlabel('symbol one');

receivedSignal   = [SymbolOne SymbolZero SymbolZero SymbolOne SymbolZero ...
    SymbolOne SymbolOne SymbolZero]; 
subplot(4,2,3);
stem(receivedSignal);
axis([-10 500 -2 2]);
xlabel('received signal');

DecodingZero     = receivedSignal .* [SymbolZero SymbolZero SymbolZero ...
    SymbolZero SymbolZero SymbolZero SymbolZero SymbolZero];
DecodingOne      = receivedSignal .* [SymbolOne SymbolOne SymbolOne ...
    SymbolOne SymbolOne SymbolOne SymbolOne SymbolOne];

subplot(4,2,5);
stem(DecodingZero);
axis([-10 500 -2 2]);
xlabel("decode zero");

subplot(4,2,6);
stem(DecodingOne);
xlabel("decode one");
axis([-10 500 -2 2]);

for k=1:(length(DecodingZero)/SamplesPerSymbol)
    SymbolOffsets_Zero(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol))...
        = mean(DecodingZero(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol)));
end

for k=1:(length(DecodingOne)/SamplesPerSymbol)
    SymbolOffsets_One(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol))...
        = mean(DecodingOne(((k-1)*SamplesPerSymbol)+1:k*(SamplesPerSymbol)));
end

subplot(4,2,7);
stem(SymbolOffsets_Zero)
xlabel("Offset zeros");
axis([-10 500 -2 2]);

subplot(4,2,8);
stem(SymbolOffsets_One)
xlabel("Offset ones");
axis([-10 500 -2 2]);
