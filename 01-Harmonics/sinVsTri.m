clc

mf=10;
refFreq=50;
carrierFreq=mf*refFreq;

%sampling freq
fs = 10000000;
%total period
t = 0:1/fs:.2;
%create Tri Wave
triWave = sawtooth(2*pi*carrierFreq*t,1/2);
figure(1)
plot(t,triWave)
%create sin wave
sinWave=sin(2*pi*refFreq*t);
figure(2)
plot(t,sinWave)

% Generate bipolar PWM
pwm_signal = 2*(triWave > sinWave)-1;
% Plot the PWM signal
figure(3)
plot(t, pwm_signal);
xlabel('Time (s)');
ylabel('PWM Signal');
title('Bipolar PWM Signal');
grid on

%harmonics content
fourierTransform=fft(pwm_signal);
fourierTransformAbs=abs(fourierTransform);
figure(4)
plot(fourierTransformAbs)