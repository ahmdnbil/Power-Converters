clc
clear all;

Vin=48;
Vo=12;
D=Vo/Vin;
L=220*10^-6;
C=10*10^-6;
R=5;
Fs=100*10^3;

M2=Vo/L;
Ma=.5*M2;

s=tf('s');

Gvc= R/(R*C*s+1);
figure(1)
bode(Gvc)
margin(Gvc)
grid on;