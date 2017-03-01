# psd_fit
Fits a model to a power spectrum, similar to Blankertz 2014, but for theta, alpha and beta peaks

Example code is in script_analysis.m, but no data

Needs a single EEG channel (EEG_CHAN) and the corresponding Sampling Rate (Fs) as input for psdfit.fit_tab();

You can plot the fitting with psdfit.plot_tab, handing it the power spectrum (Pxx) and the estimated model (gm).

The frequency range of interest is hard-set in +psdfit/get_foi.m, which is called by the functions. If you change this, the rest of the code _should_  automatically adapt (e.g. upper and lower boundaries for the fit, plotting xticks etc.)

```matlab
    [Pxx,gm]    = psdfit.fit_tab(EEG_CHAN,Fs);
    psdfit.plot_tab(gm,Pxx);
```


Robert Bauer
01.03.2017
