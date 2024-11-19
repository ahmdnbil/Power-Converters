clc
clear;

Vin=48;
Vo=12;
D=Vo/Vin;
L=220*10^-6;
C=10*10^-6;
R=5;
Fs=75*10^3;
Ts=1/Fs;

M2=Vo/L;
Ma=M2;
Fm=1/(Ma*Ts);
Fg=((D^2)*Ts)/(2*L);
Fv=((1-2*D)*Ts)/(2*L);

s=tf('s');
Zo=R/(R*C*s+1);
den=L*C*s^2+(L/R)*s+1;
Gvd=Vin*(1/den);
Gvg=D*(1/den);
Gig=Gvg/Zo;
Gid=Gvd/Zo;
den_PCM=(1+Fm*(Gid+Fv*Gvd));
Gvc=(Fm*Gvd)/den_PCM;
Gvg_PCM=(Gvg-Fm*Fg*Gvd+Fm*(Gvg*Gid-Gig*Gvd))/den_PCM;



%let's design loop gain:
%sisotool(Gvc)