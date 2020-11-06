N   =   48;
n   =   0:1:N-1;
fs  =   48000;  %% Sampling frequency
f1  =   2000;   %% frequency 1
f2  =   3*f1;   %% frequency 2
x1  =   1*sin(2*pi*(f1/fs)*n);
x2  =   1*sin(2*pi*(f1/fs)*n);
x3  =   x1.*x2;
y1  =   x1;
y2  =   1*sin(2*pi*(f2/fs)*n);
y3  =   y1.*y2;
% Plot x signal
subplot(3,2,1);
t   =   (0:1:N-1)*1/fs;
stem(t,x1);
subplot(3,2,3);
stem(t,x2);
subplot(3,2,5);
stem(t,x3);
% Plot y signal
subplot(3,2,2);
t   =   (0:1:N-1)*1/fs;
stem(t,y1);
subplot(3,2,4);
stem(t,y2);
subplot(3,2,6);
stem(t,y3);