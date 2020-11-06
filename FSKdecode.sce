//https://www.allaboutcircuits.com/technical-articles/digital-signal-processing-in-scilab-how-to-decode-an-fsk-signal/

clc;
clear;
ZeroFrequency       = 10000;
OneFrequency        = 30000;
SamplingFrequency   = 300000;
Samples_per_Symbol  = SamplingFrequency/ZeroFrequency;

n = 0:(Samples_per_Symbol-1);
Symbol_Zero         = sin(2*%pi*n / (SamplingFrequency/ZeroFrequency));
Symbol_One          = sin(2*%pi*n / (SamplingFrequency/OneFrequency));
subplot(4,2,1);
xlabel("symbol zero");
plot(n, Symbol_Zero);
subplot(4,2,2);
xlabel("symbol one");
plot(n, Symbol_One);

ReceivedSignal      = [Symbol_Zero Symbol_One Symbol_One Symbol_One Symbol_Zero Symbol_One ];
subplot(4,2,3);
xlabel("received signal");
plot(ReceivedSignal);

Decoding_Zero       = ReceivedSignal .* [Symbol_Zero Symbol_Zero Symbol_Zero Symbol_Zero Symbol_Zero Symbol_Zero];
Decoding_One        = ReceivedSignal .* [Symbol_One Symbol_One Symbol_One Symbol_One Symbol_One Symbol_One];

subplot(4,2,5);
xlabel("decode zero");
plot(Decoding_Zero);
subplot(4,2,6);
xlabel("decode one");
plot(Decoding_One);

for k=1:(length(Decoding_Zero)/Samples_per_Symbol)
    SymbolOffsets_Zero(((k-1)*Samples_per_Symbol)+1:k*(Samples_per_Symbol))= mean(Decoding_Zero(((k-1)*Samples_per_Symbol)+1:k*(Samples_per_Symbol)));
end

for k=1:(length(Decoding_One)/Samples_per_Symbol)
    SymbolOffsets_One(((k-1)*Samples_per_Symbol)+1:k*(Samples_per_Symbol))= mean(Decoding_One(((k-1)*Samples_per_Symbol)+1:k*(Samples_per_Symbol)));
end

subplot(4,2,7);
xlabel("Offset zeros");
plot(SymbolOffsets_Zero)

subplot(4,2,8);
xlabel("Offset ones");
plot(SymbolOffsets_One)
