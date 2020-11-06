% FSK Modulation and Demodulation scheme with BER Calculation
clc
clear all
% Define Data bits
data=[1 0 1 0 1 1 1 0 0 1];
% Define carrier signal
f=1000;
fs=f*100;
Ts=1/fs;
T=1/f;
M=10;
n=M*length(data);
t=0:Ts:n*T;
car=sin(2*pi*t*f);
figure;
subplot(3,1,1);
plot(car,'r');
xlabel('Samples(Carrier signal)');
ylabel('Amplitude');
% Converting data bits into pulse
tp=0:Ts:M*T;
exData=[];
 for i=1:length(data)
     for j=1:length(tp)-1
         exData=[exData data(i)];
     end
 end
 exData(1,size(exData)+1)=exData(1,size(exData));
 
 subplot(3,1,2)
 plot(exData,'g','Linewidth',2)
 xlabel('Samples(Message signal)');
 ylabel('Amplitude');
 
 % FSK Modulation schemes
 deltaf=.5;
 fh=f + (f*deltaf);
 fl=f - (f*deltaf);
 
 t=0:Ts:(T*M);
 
 carh=sin(2*pi*t*fh);       %High frequency carrier for data bit 1
 carl=sin(2*pi*t*fl);       %Low frequency carrier for data bit 0
 
 modSig=[];
 
 for i=1:length(data)
     if(data(i)==1)
         modSig=[modSig carh];
     else
         modSig=[modSig carl];
     end
 end
 
 subplot(3,1,3);
 plot(modSig,'b');
 xlabel('Samples(FSK Modulated signal)');
 ylabel('Amplitude');
 
 % Transmitting over awgn channel
 SNR=10;
 sampleValue=mod(randi(20),10)+10;
 rx=awgn(modSig,SNR);
 figure;
 subplot(2,1,1);
 plot(modSig,'b');
 xlabel('Samples(FSK Modulated signal)');
 ylabel('Amplitude');
 subplot(2,1,2);
 plot(rx,'r');
 xlabel('Samples(FSK Recieved signal)');
 ylabel('Amplitude');
 % Demodulation of recieved signal
 % Finding no of zeros in interval of tp i.e finding frequency of signal at every interval
 negative=0;
 positive=0;
 
 totalBits=length(rx)/length(tp);
 sdiff=0;
 noofzeros=0;
 zeroSample=[];
 k=1;
 for i=1:totalBits
     for j=1:length(tp)
         if(sdiff>sampleValue)
         if(rx(1,k)>0)
             positive=1;
         end
         if(rx(1,k)<0)
             negative=1;
         end
         end
         k=k+1;
         sdiff=sdiff+1;
         if(positive==1 && negative==1)
             noofzeros=noofzeros+1;
             positive=0;
             sdiff=0;
             negative=0;
         end
     end
     zeroSample=[zeroSample noofzeros];
     noofzeros=0;     
 end
 
 firstZeroSample=zeroSample(1,1);
 zeroSample=zeroSample/firstZeroSample;
 
 % Generating data according to given frequency samples or given zero samples
 filtData=[];
 for i=1:length(zeroSample)
     if(zeroSample(i)>=1)
         filtData=[filtData 1];
     else
         filtData=[filtData 0];
     end
 end
 
 figure;
 subplot(3,1,1);
 stem(data,'b','Linewidth',2);
 xlabel('Samples(Message signal)');
 ylabel('Amplitude');
 subplot(3,1,2);
 stem(filtData,'g','Linewidth',2);
 xlabel('Samples(Recieved signal)');
 ylabel('Amplitude');
 subplot(3,1,3);
 stem(abs(data-filtData),'r','Linewidth',2);
 xlabel('Samples(Error signal)');
 ylabel('Amplitude');
 
% Finding Bit error rate
 [BER NOR]=biterr(data,filtData)