function [g1,g2,gm] = fit_psd(Pxx)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predefinitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f       = 1:length(Pxx);
g       = fittype('(k1+(k2/x.^l)) + (k3*exp(-((x-u1)/s1)^2)) + (k4*exp(-((x-u2)/s2)^2))','coefficients',{'k1','k2','k3','k4','l','u1','u2','s1','s2'});
gopt    = fitoptions(g);
gopt.DiffMinChange = 0.01;
gopt.Upper      = [Inf Inf max(Pxx) max(Pxx) 1 30 70 12 12];
gopt.Lower      = [0 0 0 0 0 8 30 4 4];

gopt.StartPoint = [mean(Pxx) max(Pxx) Pxx(10)  Pxx(10) Pxx(20) 0.1 10 20 4.5 4.5];
gopt.MaxIter    = 1000;
gopt.MaxFunEvals = 1200;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[gm , ~, ~] = fit(f',Pxx',g,gopt);
g1(1,:) = gm.k1+(gm.k2./f.^gm.l);
g2(1,:) = (gm.k3*exp(-((f-gm.u1)./gm.s1).^2)) + (gm.k4*exp(-((f-gm.u2)./gm.s2).^2));


end