clc;
clear;
close all;

%power stage component
L=50*10^(-6);
R=3;
C=500*10^(-6);
Fs=100*10^(3);
Vin=28;
V=15;
D=V/Vin;
R1=20*10^(3);
R2=10*10^(3);

%compensator
s=tf('s');
Q=R*sqrt(C/L);
Wo=1/sqrt(L*C);
den=(s/Wo)^2+(s/(Wo*Q)+1);
Gdo=V/D;
Ggo=D;
Vm=4;
Gvg=Ggo*(1/den);
Gvd=Gdo*(1/den);
Gm=1/Vm;
H=1/3;
T_un=Gvd*H*Gm;
figure(1)
bode(Gvd);
figure(2)
bode(T_un)
margin(T_un)
grid on;

%required Fc=Fs/20 =5Khz
Fc=Fs/20;
reqGain=dcgain(T_un)*(Wo/(Fc*2*pi))^2;
reqPM=52;
Fz_PD=Fc*sqrt((1-sind(reqPM))/(1+sind(reqPM)));
Fp_PD=Fc*sqrt((1+sind(reqPM))/(1-sind(reqPM)));
Gco_PD=sqrt(Fz_PD/Fp_PD)/reqGain;
Gc_PD=Gco_PD*(1+(s/(Fz_PD*2*pi)))/(1+(s/(Fp_PD*2*pi)));

%T(S) with PD
T_PD=series(T_un,Gc_PD);
figure(3)
bode(T_PD)
margin(T_PD)
grid on;
hold on;
bode(T_un);
hold off;

figure(4)
bode(T_PD);
grid on;
hold on;
bode(1/(T_PD+1));

%adding inverted zero
WL=(Fc/10)*2*pi; %choose it less than cross over frequency
TF_inv=(1+(WL/s));
T_inverted=series(T_PD,TF_inv);
figure(5)
bode(T_inverted);
margin(T_inverted);
grid on;
hold on;
bode(T_un);
hold off;

%testing or attenuation TF
figure(6)
bodeplot(1/(1+T_inverted));
hold on;
grid on;
bodeplot(Gvg);
bodeplot(Gvg*(1/(1+T_inverted)));