function main()
    clear all; clc; close all;
    
    kp = .8; %step 3
    kd = .014; % step 3
    Tfs = calcTF(kp, kd);
    TF1_A = Tfs(1);
    TF2_A = Tfs(2);
    [p1A, z1A] = pzmap(TF1_A)
    [p2A, z2A] = pzmap(TF2_A)
    subplot(221)
    pzplot(TF1_A)
    subplot(222)
    pzplot(TF2_A)
    
    
    clear;
    kp = .21; %step 5
    kd = .042; %step 5
    Tfs = calcTF(kp, kd);
    TF1_B = Tfs(1);
    TF2_B = Tfs(2);
    [p1B, z1B] = pzmap(TF1_B)
    [p2B, z2B] = pzmap(TF2_B)
    subplot(223)
    pzplot(TF1_B)
    subplot(224)
    pzplot(TF2_B)

    nr = 220;
    count = 0;
    
    %Plot root loci according to ratios
    figure;
    for ratio = [.05, 0.10, .17, .25]
%     for ratio = [.3, 1]
        Tfs = calcTF(ratio);        
        TF1 = Tfs(1);
        TF2 = Tfs(2);
        
        %Get Poles, Zeroes, Root Loci
        if count == 4
           count = 0; 
           figure;
        end
        
        count = count +1 ;
        rootloci(TF1, nr + count);
        count = count +1;
        rootloci(TF2, nr + count);
    end
end

function OpenLoopTransferFunctions = calcTF(varargin)
    %nargin = 2 - kp,kd given
    %nargin = 1 - ratio
    
    s = tf('s');

    khw = 13803; %from parameters reference
    m1 = 522.2 + 492.5 + 492.8 + 494.7 + 809.1;
    m1 = m1/1000;
    m2 = 490.9 + 494.9 + 496.0 + 245.0 + 656.5;
    m2 = m2/1000;
    k2 = 426.2150; %from parameters reference

    Ds =(m1*m2)*s^4 + (m1*(k2) + m2*(k2))*s^2;
    N1 = m2*s^2 + k2;
    N2 = k2;
    
    if nargin == 2
        kp = varargin{1};
        kd = varargin{2};
        G1 = (kp + kd*s)*khw * N1/Ds;
        G2 = (kp + kd*s)*khw * N2/Ds;
    elseif nargin == 1
        ratio = varargin{1};
        G1 = (1 + ratio*s)*khw * N1/Ds;
        G2 = (1 + ratio*s)*khw * N2/Ds;
    end
        
    OpenLoopTransferFunctions = [G1 G2];
end


function plot = rootloci(TF, nr)

    [p,z] = pzmap(TF)
%     pzplot(TF)
    subplot(nr);
    h = rlocusplot(TF);
    p = getoptions(h);
%     p.Title.String = 'My Title \frac{A-A(-1)}{Y}  (\it{\frac{x}})';
    setoptions(h,p);
end