function Pxx = estimate_psd(EEG,Fs)
    FOI = psdfit.get_foi();
    Pxx = log10(pwelch(EEG,Fs*4,Fs*2,FOI,Fs));