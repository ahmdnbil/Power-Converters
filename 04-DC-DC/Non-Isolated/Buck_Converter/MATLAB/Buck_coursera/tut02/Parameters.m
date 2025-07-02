clc;
clear;

%power stage parameters
Vg=5;
L=1e-6;
C=200e-6;
Resr=.8e-3;
Rs=30e-3;
R=10e3;
Fs=1e+6;
Vref=1.8;
VM=1;

%control stage
s=tf('s');
H=1;
Wo=1/sqrt(L*C);
Wesr=1/(Resr*C);
Gvdo=Vg;
Qload=R*sqrt(C/L);
Qloss=sqrt(L/C)/(Resr+Rs);
Q=(Qload*Qloss)/(Qload+Qloss);
den=1+(1/(Q*Wo))*s+s^2*(1/Wo^2);
Gvd=Gvdo*(1+(s/Wesr))/den;

%bode plot
Fmin=10;
Fmax=1e6;
BodeOptions=bodeoptions;
BodeOptions.FreqUnits='Hz';
BodeOptions.Xlim=[Fmin Fmax];
BodeOptions.Grid='on';
GvdFig01=figure(1);
bode(Gvd,BodeOptions,'b');

T_un=(1/VM)*H*Gvd;
%adding controller PD to add phase boost and move cross over freq
reqPM=53;
Fc_req=100e+3;
Wc_req=Fc_req*2*pi;
reqGain=dcgain(T_un)*(Wo/Wc_req)^2;
Fz_PD=Fc_req*sqrt((1-sind(reqPM))/(1+sind(reqPM)));
Fp_PD=Fc_req*sqrt((1+sind(reqPM))/(1-sind(reqPM)));
PD_gain=sqrt(Fz_PD/Fp_PD)/reqGain;
Gpd=PD_gain*(1+s/(Fz_PD*2*pi))/(1+s/(Fp_PD*2*pi));

%adding HF pole at Fs
Fp2=Fs;
Tf_HFP=1/(1+s/(Fp2*2*pi));
Gpd_pole=series(Gpd,Tf_HFP);

T_pd=series(T_un,Gpd_pole);
figurePD=figure(2);
margin(T_pd);
bode(T_pd,BodeOptions,'b');


%adding Low freq inverted zero to increase low gain freq
% 10*FL < Fc
FL=8e+3;
WL=FL*2*pi;
Tf_invZero=(1+WL/s);
TF_final=series(T_pd,Tf_invZero);

TF_final_fig=figure(3);
bode(TF_final,BodeOptions,'b');