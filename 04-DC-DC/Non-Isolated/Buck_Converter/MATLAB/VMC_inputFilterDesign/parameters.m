clc;
clear all;

R=5;
L=220*10^-6;
C=5*10^-4;

D=.25;
Vin=48;
Vm=5;
Wo=1/sqrt(L*C);
Q=R*sqrt(C/L);

s=tf('s');

Gvd=Vin/((s/Wo)^2+(s/(Wo*Q))+1);
figure(1)
bode(Gvd)
margin(Gvd)
grid on;

Gm=1/Vm;
T=series(Gm,Gvd);

