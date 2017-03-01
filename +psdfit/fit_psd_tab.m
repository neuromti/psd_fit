function [gm,g1,g2] = fit_psd_tab(Pxx)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predefinitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FOI             = psdfit.get_foi();
FOI_SCALE       = mean(diff(FOI));
theta           = get_bound([3,7]);
alpha           = get_bound([8,14]);
beta            = get_bound([15,35]);

f       = 1:length(FOI);
g       = fittype('(k1+(k2/x.^l)) + (k3*exp(-((x-u1)/s1)^2)) + (k4*exp(-((x-u2)/s2)^2)) + (k5*exp(-((x-u3)/s3)^2))','coefficients',{'k1','k2','k3','k4','k5','l','u1','u2','u3','s1','s2','s3'});
gopt    = fitoptions(g);
gopt.DiffMinChange = 0.01;
gopt.Upper      = [Inf Inf max(Pxx) max(Pxx) max(Pxx) 1 max(theta) max(alpha) max(beta) 6/FOI_SCALE 6/FOI_SCALE 6/FOI_SCALE];
gopt.Lower      = [0 0 0 0 0 0 min(theta) min(alpha) min(beta) 3/FOI_SCALE 3/FOI_SCALE 3/FOI_SCALE];
gopt.StartPoint = [mean(Pxx) max(Pxx) Pxx(5) Pxx(10) Pxx(20) 0.1 mean(theta) mean(alpha) mean(beta) 1/FOI_SCALE 1/FOI_SCALE 1/FOI_SCALE];
gopt.MaxIter    = 1000;
gopt.MaxFunEvals = 1200;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[gm , ~, ~] = fit(f',Pxx',g,gopt);
g1(1,:) = gm.k1+(gm.k2./f.^gm.l);
g2(1,:) = (gm.k3*exp(-((f-gm.u1)./gm.s1).^2)) + (gm.k4*exp(-((f-gm.u2)./gm.s2).^2)) + (gm.k5*exp(-((f-gm.u3)./gm.s3).^2));

end

function bnd = get_bound(fbnd)
    FOI     = psdfit.get_foi();    
    bnd     = [];
    if max(fbnd)>max(FOI), error('FOI:BNDHI','Frequency of Interest Boundary not within estimation range, too high'), end
    if min(fbnd)<min(FOI), error('FOI:BNDLO','Frequency of Interest Boundary not within estimation range, too low'), end 
    for idx = 1 : length(fbnd)              
        [~,bnd_srt]    	= sort(abs(FOI-fbnd(idx)));
        bnd(idx)         = bnd_srt(1);
    end
end