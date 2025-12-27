clc
clear
Vin=24;
Vo=60;
C=33*10^-6;
R=20;
L=100*10^-6;
Fs=100*10^3;
T=1/Fs;
Rf=.1;
D=1-Vin/Vo;
D_prime=1-D;
%Steady-State Solution
M1=Vin/L;
M2=(Vo-Vin)/L;
Ma=M2;
Va=Rf*Ma*(1/Fs);
IL=Vo^2/R/Vin;
%transfer Functions
s=tf('s');
%simple model
Gvc=(D_prime*R/2/Rf)*(1-s*(L/(D_prime^2)/R))/(1+s*R*C/2);

%duty controlled
den=1+s*(L/(D_prime^2)/R)+s^2*(L*C/D_prime^2);
Gvdo=Vo/D_prime;
Gvd=Gvdo*(1-s*(L/(D_prime^2)/R)/den);
Gido=2*Vo/(D_prime^2)/R;
Gid=Gido*(1+s*R*C/2)/(den);
Gvgo=1/D_prime;
Gvg=Gvgo*1/den;
figure(1)
bode(Gvd);
margin(Gvd)
grid on;

%more accurate model
Fm=Fs/(Ma+(M1-M2)/2/Fs);
Fg=0;
Fv=D*D_prime/(2*Fs*L);
Wc=D_prime/sqrt(L*C)*sqrt(1+2*Fm*Vo/(D_prime^2)/R+Fm*Fv*Vo/D_prime);
Qc=D_prime*R*sqrt(C/L)*(sqrt(1+2*Fm*Vo/(D_prime^2)/R+Fm*Fv*Vo/D_prime)/(1+R*C*Fm*Vo/L-Fm*Fv*Vo/D_prime));
Gco=(Vo/D_prime/Rf)*Fm/(1+2*Fm*Vo/(D_prime^2)/R+Fm*Fv*Vo/D_prime);
Gvc_acc=Gco*(1-s*L/(D_prime^2)/R)/(1+s/Qc/Wc+(s/Wc)^2);

figure(2)
bode(Gvc)
margin(Gvc)
grid on
hold on;
bode(Gvc_acc);
legend("Gvc","Gvc_accurate");
%PWM Bode Plot
PWM=(1-exp(-s*T))/(s*T);
figure(3)
bode(PWM)
grid on;
hold on;
PWM_approx=1/(s/2/Fs+1);
bode(PWM_approx);
legend("PWM","PWM approximate");
