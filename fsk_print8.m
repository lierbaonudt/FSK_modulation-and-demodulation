clc;
clear;
close all;
for i = 1:1:256
    formatSpec = "max(myPeaksDetector(y_Corr%d(1:1281)))\n";
    fprintf(formatSpec,i);
end