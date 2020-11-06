//https://www.allaboutcircuits.com/technical-articles/how-to-use-i-q-signals-to-design-a-robust-fsk-decoder/
clc;
clear all;

ZeroFrequency = 10e3;
OneFrequency = 30e3;
SamplingFrequency = 300e3;
Samples_per_Symbol = SamplingFrequency/ZeroFrequency;
n = 0:(Samples_per_Symbol-1);

Symbol_Zero_I = cos(2*%pi*n / (SamplingFrequency/ZeroFrequency));
Symbol_One_I = cos(2*%pi*n / (SamplingFrequency/OneFrequency));
Symbol_Zero_Q = sin(2*%pi*n / (SamplingFrequency/ZeroFrequency));
Symbol_One_Q = sin(2*%pi*n / (SamplingFrequency/OneFrequency));

figure(1);
subplot(2,2,1)
plot(n, Symbol_Zero_I)
subplot(2,2,2)
plot(n, Symbol_One_I)
subplot(2,2,3)
plot(n, Symbol_Zero_Q)
subplot(2,2,4)
plot(n, Symbol_One_Q)

Symbol_Zero_I_45deg = cos(%pi/4 + 2*%pi*n / (SamplingFrequency/ZeroFrequency));
Symbol_One_I_45deg = cos(%pi/4 + 2*%pi*n / (SamplingFrequency/OneFrequency));
Symbol_Zero_Q_45deg = sin(%pi/4 + 2*%pi*n / (SamplingFrequency/ZeroFrequency));
Symbol_One_Q_45deg = sin(%pi/4 + 2*%pi*n / (SamplingFrequency/OneFrequency));
Symbol_Zero_I_90deg = cos(%pi/2 + 2*%pi*n / (SamplingFrequency/ZeroFrequency));
Symbol_One_I_90deg = cos(%pi/2 + 2*%pi*n / (SamplingFrequency/OneFrequency));
Symbol_Zero_Q_90deg = sin(%pi/2 + 2*%pi*n / (SamplingFrequency/ZeroFrequency));
Symbol_One_Q_90deg = sin(%pi/2 + 2*%pi*n / (SamplingFrequency/OneFrequency));

Baseband_I_aligned = [Symbol_Zero_I Symbol_One_I Symbol_Zero_I Symbol_One_I];
Baseband_Q_aligned = [Symbol_Zero_Q Symbol_One_Q Symbol_Zero_Q Symbol_One_Q];
Baseband_I_45deg = [Symbol_Zero_I_45deg Symbol_One_I_45deg Symbol_Zero_I_45deg Symbol_One_I_45deg];
Baseband_Q_45deg = [Symbol_Zero_Q_45deg Symbol_One_Q_45deg Symbol_Zero_Q_45deg Symbol_One_Q_45deg];
Baseband_I_90deg = [Symbol_Zero_I_90deg Symbol_One_I_90deg Symbol_Zero_I_90deg Symbol_One_I_90deg];
Baseband_Q_90deg = [Symbol_Zero_Q_90deg Symbol_One_Q_90deg Symbol_Zero_Q_90deg Symbol_One_Q_90deg];

figure(2);
subplot(3,2,1)
plot(Baseband_I_aligned)
subplot(3,2,2)
plot(Baseband_Q_aligned)
subplot(3,2,3)
plot(Baseband_I_45deg)
subplot(3,2,4)
plot(Baseband_Q_45deg)
subplot(3,2,5)
plot(Baseband_I_90deg)
subplot(3,2,6)
plot(Baseband_Q_90deg)

DecodeZero_I_aligned = Baseband_I_aligned .* [Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I];
DecodeZero_Q_aligned = Baseband_Q_aligned .* [Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I];
DecodeOne_I_aligned = Baseband_I_aligned .* [Symbol_One_I Symbol_One_I Symbol_One_I Symbol_One_I];
DecodeOne_Q_aligned = Baseband_Q_aligned .* [Symbol_One_I Symbol_One_I Symbol_One_I Symbol_One_I];

DecodeZero_I_45deg = Baseband_I_45deg .* [Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I];
DecodeZero_Q_45deg = Baseband_Q_45deg .* [Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I];
DecodeOne_I_45deg = Baseband_I_45deg .* [Symbol_One_I Symbol_One_I Symbol_One_I Symbol_One_I];
DecodeOne_Q_45deg = Baseband_Q_45deg .* [Symbol_One_I Symbol_One_I Symbol_One_I Symbol_One_I];

DecodeZero_I_90deg = Baseband_I_90deg .* [Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I];
DecodeZero_Q_90deg = Baseband_Q_90deg .* [Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I Symbol_Zero_I];
DecodeOne_I_90deg = Baseband_I_90deg .* [Symbol_One_I Symbol_One_I Symbol_One_I Symbol_One_I];
DecodeOne_Q_90deg = Baseband_Q_90deg .* [Symbol_One_I Symbol_One_I Symbol_One_I Symbol_One_I];

figure(3);
subplot(2,2,1)
plot(DecodeZero_I_aligned)
subplot(2,2,2)
plot(DecodeZero_Q_aligned)
subplot(2,2,3)
plot(DecodeOne_I_aligned)
subplot(2,2,4)
plot(DecodeOne_Q_aligned)

figure(4);
subplot(2,2,1)
plot(DecodeZero_I_45deg)
subplot(2,2,2)
plot(DecodeZero_Q_45deg)
subplot(2,2,3)
plot(DecodeOne_I_45deg)
subplot(2,2,4)
plot(DecodeOne_Q_45deg)

figure(5);
subplot(2,2,1)
plot(DecodeZero_I_90deg)
subplot(2,2,2)
plot(DecodeZero_Q_90deg)
subplot(2,2,3)
plot(DecodeOne_I_90deg)
subplot(2,2,4)
plot(DecodeOne_Q_90deg)
