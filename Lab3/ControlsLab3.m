function main()
    clear all; clc; close all;
    
    kp = .8; %step 3
    kd = .014; % step 3
    Tfs = calcTF(kp, kd);
    TF1_A = Tfs(1);
    TF2_A = Tfs(2);
    
    kp = .21; %step 5
    kd = .042; %step 5
    Tfs = calcTF(kp, kd);
    TF1_B = Tfs(1);
    TF2_B = Tfs(2);

    nr = 220;
    count = 0;

    %Plot root loci according to ratios
    for ratio = [.05, 0.10, .17, .25]
        %step 3
        Tfs = calcTF(ratio);
        TF1_A = Tfs(1);
        TF2_A = Tfs(2);
        
        %Get Poles, Zeroes, Root Loci
        if count == 4
           count = 0; 
           figure;
        end
        count = count +1 ;
        rootloci(TF1_A, nr + count);
        count = count +1;
        rootloci(TF2_A, nr + count);
    end
end

% function TransferFunctions = calcTF(varargin)
%     %nargin = 2 - kp,kd given
%     %nargin = 1 - ratio
%     
%     if nargin == 2
%         kp = varargin{1};
%         kd = varargin{2};
%     else
%         if nargin == 1
%         ratio = varargin{1};
%         kp = ratio;
%         %ratio
%         end
%     end
%         
%     s = tf('s');
% 
%     khw = 16.1000; %from parameters reference
%     m1 = 522.2 + 492.5 + 492.8 + 494.7 + 809.1;
%     m1 = m1/1000;
%     m2 = 490.9 + 494.9 + 496.0 + 245.0 + 656.5;
%     m2 = m2/1000;
%     k2 = 426.2150; %from parameters reference
% 
%     Ds =(m1*m2)*s^4 + (m1*(k2) + m2*(k2))*s^2;
%     N1 = m2*s^2 + k2;
%     N2 = k2;
%     G1 = (kp + kd*s)*khw * N1/Ds;
%     G2 = (kp + kd*s)*khw * N2/Ds;
%     TF1 = G1/(1+G1);
%     TF2 = G2/(1+G2);
%     %changed
%     TransferFunctions = [G1 G2];
% end

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