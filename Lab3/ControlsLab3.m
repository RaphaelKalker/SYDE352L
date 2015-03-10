function main()
    clear all; clc; close all;

    Tfs = calcTF();
    TF1 = Tfs(1);
    TF2 = Tfs(2);
    
    %Get Poles,Zeroes, Root Loci
    rootloci(TF1);
    rootloci(TF2);

end


%Simplify that nasty beast
% pretty(simplify(N1/Ds))
% pretty(simplify(N2/Ds))
% pretty(vpa(simplify(TF_x1)))
% pretty(simplify(TF_x2))

function TransferFunctions = calcTF(varargin)

if nargin < 1
    kp = .8; %step 3
    kd = .014 %step 3
else
    ratio = varagin{1} % kd/kp
end
    s = tf('s');

khw = 13803; %from parameters reference
m1 = 522.2 + 492.5 + 492.8 + 494.7;
m1 = m1/1000;
m2 = 490.9 + 494.9 + 496.0 + 245.0;
m2 = m2/1000;
k2 = 426.2150; %from parameters reference

% Ds =(m1*m2)*s^4 + (m1*c2 + m2*c1)*s^3 + (m1*(k2+k3) + m2*(k1+k2) +c1*c2)*s^2 + (c1*(k2 + k3)+c2*(k1+k2))*s + (k1*k2 + k1*k3 + k2*k3); %correct
Ds =(m1*m2)*s^4 + (m1*(k2) + m2*(k2))*s^2; %correct
% N1 = m2*s^2 + c2*s + k2 +k3; %correct
N1 = m2*s^2 + k2; %correct
N2 = k2; %correct
G1 = (kp + kd*s)*khw * N1/Ds;
G2 = (kp + kd*s)*khw * N2/Ds;
TF1 = G1/(1+G1)
TF2 = G2/(1+G2)

TransferFunctions = [TF1 TF2];

end

function plot = rootloci(TF)
    figure;
    [p,z] = pzmap(TF)
    pzplot(TF)
    figure;
    h = rlocusplot(TF);
    p = getoptions(h);
    p.Title.String = 'My Title \frac{A-A(-1)}{Y}  (\it{\frac{x}})';
    setoptions(h,p);
end






