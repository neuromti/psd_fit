function [Pxx,gm] = fit_tab(EEG,Fs)

Pxx         = psdfit.estimate_psd(EEG,Fs); 
Pxx         = psdfit.normalize_psd(Pxx);
gm          = psdfit.fit_psd_tab(Pxx);  