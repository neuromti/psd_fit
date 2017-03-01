function g = calc_noisefloor(gm)
    f   = 1 : length(psdfit.get_foi);
    g   = gm.k1+(gm.k2./f.^gm.l);