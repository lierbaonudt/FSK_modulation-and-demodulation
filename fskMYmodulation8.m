% https://www.allaboutcircuits.com/technical-articles/digital-signal-processing-in-scilab-how-to-decode-an-fsk-signal/
% mducng, SoC team, G2touch
% For MPP2.0: Erase or Right click
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;
close all;
f_tip            =  25007;
f_ring           =  170455;
f_ring_hover     =  179545;
Fs               =  4000000;
SamplesPerSymbol =  470*4; % 1038*10^(-6)*Fs = 1038*4 (1038 is from spec)
n                =  0:(SamplesPerSymbol-1);
t                =  n*1/Fs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SymbolBaseTip           =  10*(1+cos(2*pi*f_tip*t));
SymbolBaseRing          =  10*(1+cos(2*pi*f_ring*t));
SymbolBaseRingHover     =  10*(1+cos(2*pi*f_ring_hover*t));
MixedSignal             =  (1+cos(2*pi*f_tip*t)) + (1+cos(2*pi*f_ring*t));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tRx                     = (0:length(MixedSignal)-1)*1/Fs;
DecodingTip             = MixedSignal .* SymbolBaseTip;
DecodingRing            = MixedSignal .* SymbolBaseRing;
DecodingRingHover       = MixedSignal .* SymbolBaseRingHover;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:(length(DecodingTip)/SamplesPerSymbol)
    SymbolOffsets_Tip((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol))	= ...
        mean(DecodingTip((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)));
end
for k=1:(length(DecodingRing)/SamplesPerSymbol)
    SymbolOffsets_Ring((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol))	= ...
        mean(DecodingRing((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)));
end
for k=1:(length(DecodingRingHover)/SamplesPerSymbol)
    SymbolOffsets_RingHover((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol))	= ...
        mean(DecodingRingHover((((k-1)*SamplesPerSymbol)+1):k*(SamplesPerSymbol)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure;
subplot(5,1,1);
plot(t, MixedSignal);
axis([-100*1/Fs 2000*1/Fs -1 8]);
xlabel('Signal of mixed Tip + Ring.');

subplot(5,1,2);
plot(tRx,DecodingTip);
axis([-100*1/Fs 2000*1/Fs -10 80]);
xlabel("Decoding by signal Tip base.");

subplot(5,1,3);
plot(tRx,DecodingRing);
axis([-100*1/Fs 2000*1/Fs -10 80]);
xlabel("Decoding by signal Ring base.");

subplot(5,1,4);
plot(tRx,DecodingRingHover);
axis([-100*1/Fs 2000*1/Fs -10 80]);
xlabel("Decoding by signal Ring Hover base.");

subplot(5,1,5);
plot(tRx,SymbolOffsets_Tip,'-r',tRx,SymbolOffsets_Ring,'-b',tRx,SymbolOffsets_RingHover,'-g')
axis([-100*1/Fs 2000*1/Fs 15 30]);
xlabel("Offset calculation.");

%subplot(2,1,2);
%plot(tRx,SymbolOffsets_One)
%axis([-1000*1/Fs 7000*1/Fs -100 6000]);
%xlabel("Offset One calculation.");
