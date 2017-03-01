# psd_fit
Fits a model to a power spectrum, similar to Blankertz 2014, but for theta, alpha and beta peaks

Example code is in script_analysis.m, but no data

Needs a single EEG channel and the corresponding Sampling Rate as input for psdfit.fit_tab

You can plot the fitting with psdfit.plot_tab.

The frequency range of interest is hard-set in psdfit.get_foi. If you change this, the rest of the code _should_  automatically adapt (e.g. upper and lower boundaries for the fit, plotting xticks etc.)

Robert Bauer
01.03.2017
