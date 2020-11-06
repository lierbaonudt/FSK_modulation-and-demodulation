% https://www.allaboutcircuits.com/technical-articles/digital-signal-processing-in-scilab-how-to-decode-an-fsk-signal/
% mducng, SoC team, G2touch
% For MPP2.0: Erase or Right click
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;
close all;
fbase            =  25007;
f1               =  25007;
Fs               =  4000000;
SamplesPerSymbol =  1038*4; % 1038*10^(-6)*Fs = 1038*4 (1038 is from spec)
n                =  0:(SamplesPerSymbol-1);
t                =  n*1/Fs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SymbolBase       =  1+cos(2*pi*fbase*t);
SignalER         =  1+cos(2*pi*f1*t + pi);
SignalRC         =  1+cos(2*pi*f1*t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tRx              = (0:length(SignalER)-1)*1/Fs;
DecodingER       = SignalER .* SymbolBase;
DecodingRC       = SignalRC .* SymbolBase;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:(length(DecodingER)/SamplesPerSymbol)
    SymbolOffsets_ER((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol))	= ...
        mean(DecodingER((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)));
end
for k=1:(length(DecodingRC)/SamplesPerSymbol)
    SymbolOffsets_RC((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol))	= ...
        mean(DecodingRC((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure;
subplot(5,1,1);
plot(t, SignalER);
axis([-1000*1/Fs 6000*1/Fs -1 5]);
xlabel('Signal of frequency ER.');

subplot(5,1,2);
plot(t, SignalRC);
axis([-1000*1/Fs 6000*1/Fs -1 5]);
xlabel('Signal of frequency RC.');

subplot(5,1,3);
plot(tRx,DecodingER);
axis([-1000*1/Fs 6000*1/Fs -1 5]);
xlabel("Decoding of signal ER.");

subplot(5,1,4);
plot(tRx,DecodingRC);
axis([-1000*1/Fs 6000*1/Fs -1 5]);
xlabel("Decoding of signal RC.");

subplot(5,1,5);
plot(tRx,SymbolOffsets_ER,'-b',tRx,SymbolOffsets_RC,'-r')
axis([-1000*1/Fs 6000*1/Fs 0 2]);
xlabel("Offset calculation.");

%subplot(2,1,2);
%plot(tRx,SymbolOffsets_One)
%axis([-1000*1/Fs 7000*1/Fs -100 6000]);
%xlabel("Offset One calculation.");