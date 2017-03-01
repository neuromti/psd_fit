function Pxx = normalize_psd(Pxx)
    Pxx         = (Pxx-min(Pxx));
    Pxx         = Pxx./max(Pxx);