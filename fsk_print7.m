clc;
clear;
close all;
for i = 1:1:256
    formatSpec = "y_Corr%d              = conv(SymbolPressure%d,SymbolRef);\n";
    fprintf(formatSpec,i,i);
end