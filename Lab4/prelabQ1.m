%prelab

khw = 13803;
m1 = (522.2 + 492.5 + 492.8 + 494.7 + 809.1)/1000;
m2 = (490.9 + 494.9 + 496.0 + 245.0 + 656.5)/1000;
kspring = 426.2150;

num = [khw*m2 0 khw*kspring 0];
den = [m1*m2 0 (m2+m1)*kspring 0 0];

sys = tf(num, den);
rlocus(sys);
kv = rlocfind(sys)
%select a point about the vertex of the top left root locus curve to
%minimum theta, which maximizes damping
%that gives us kv = 0.0045


