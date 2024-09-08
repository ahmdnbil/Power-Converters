clc
t=0:.0001:1;
F=50;
y=square(2*pi*F*t);
figure(1)
plot(t,y)

fourierTransform=fft(y);
figure(2)
plot(fourierTransform)

fourierTransformAbs=abs(fourierTransform);
figure(3)
plot(fourierTransformAbs)