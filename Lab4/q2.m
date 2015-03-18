s = tf('s');

khw = 13803; %from parameters reference
m1 = 522.2 + 492.5 + 492.8 + 494.7 + 809.1;
m1 = m1/1000;
m2 = 490.9 + 494.9 + 496.0 + 245.0 + 656.5;
m2 = m2/1000;
k2 = 426.2150; %from parameters reference
kv = 1;

Ds =(m1*m2)*s^4 + (m1*(k2) + m2*(k2))*s^2;
N1 = m2*s^2 + k2;
N2 = k2;
Dstar = Ds +khw*kv*s*N1;
Gstar = khw*(-k2)/Dstar;
Gs_complexPs = pole(Gstar);

%Design a notch filter
pole1 = 2*pi*(-5 + i*5);
pole2 = 2*pi*(-5 - i*5);
pole3 = 2*pi*(-8 + i*8);
pole4 = 2*pi*(-8 - i*8);

%Nn zeros of notch filter = complex poles of Gstar
Nn = (s + Gs_complexPs(3))*(s+Gs_complexPs(4));
Dn = (s+pole1)*(s+pole2)*(s+pole3)*(s+pole4);

notchFilter = tf(Nn/Dn);
pzmap(notchFilter);


