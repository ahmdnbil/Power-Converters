clc;
clear;

s=tf('s');

%*******************Power Stage*******************%
Vin=50;
L=220*10^-6;
C=5*10^-4;
Io=2;
Vo=12;
R=Vo/Io;
D=Vo/Vin;
Wo=1/sqrt(L*C);
Q=R*sqrt(C/L);


%*******************Control Stage*******************%
%PWM
Fs=1e5;
Ws=Fs*2*pi;
Vm=5;
Gm=1/Vm;

% Voltage Sensing
Vref=5;
H=Vref/Vin;
R1=1e4;
R2=9e4;

%Transfer Fucntions
den=1+(s/(Q*Wo))+(s/Wo)^2;
Ggo=D; %V/Vg
Gdo=Vin; %V/D
Gd=Gdo*(1/den);
Gg=Ggo*(1/den);

%poels and zeros of type III compensator
Wz1=(Wo/10)*3;
Wz2=(Wo/10)*5;
Wp1=Ws*1.2;
Wp2=Ws*1.5;

T_un=Gm*H*Gd;
