function Ek = solveKeplerEq(M, e)

% clearvars
% clear all
% clc

% M = 0.5;
% e = 0.005;
eps = 1e-15;%중단조건

Ek = M;%초기값

for k = 1:10
    fE = M -Ek + e*sin(Ek);
    fpE = -1 + e*cos(Ek);
    Ekp1 = Ek - fE/fpE;
      fprintf('%d  %12.8f %12.8f\n',k, Ek, Ekp1)
    if abs(Ekp1-Ek)<eps
        break
    end

    Ek = Ekp1;

end