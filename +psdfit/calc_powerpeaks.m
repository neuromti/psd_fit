function g = calc_powerpeaks(gm)
    f   = 1 : length(psdfit.get_foi);
    g   = (gm.k3*exp(-((f-gm.u1)./gm.s1).^2)) + (gm.k4*exp(-((f-gm.u2)./gm.s2).^2)) + (gm.k5*exp(-((f-gm.u3)./gm.s3).^2));