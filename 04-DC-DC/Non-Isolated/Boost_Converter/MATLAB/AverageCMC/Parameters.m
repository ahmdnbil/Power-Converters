clc
clear

L=250e-6;
Rf=.25;
Vin=170;
C=33e-6;
Vo=400;
Po=2e3;
R=Vo^(2)/Po;
Fs=100e3;
Vm=4;
D_prime=Vin/Vo;
D=1-D_prime;
Iin=Po/Vin;
Vc=Rf*Iin;
Pfloss=Rf*Iin^2; %power losses too high so we use low side sensing resistor instead
H=.0075;
%Transfer functions
s=tf('s');
den=1+s*L/(D_prime^(2))/R+s^(2)*L*C/(D_prime^(2));
Gid=2*Vo/(D_prime^(2))/R*(1+s*R*C/2)/den;
Gvd=Vo/D_prime/den*(1-s*L/(D_prime^2)/R);
Tiu=Rf*(1/Vm)*Gid;
Gic=1.6018e05*(1/s)*((s+3340)/(s+2.427e05));
%current loop gain
figure(1)
bode(Tiu*Gic);
margin(Tiu*Gic)
grid on;
%voltage loop gain
Tvu=(Gvd/Gid/Rf)*H;