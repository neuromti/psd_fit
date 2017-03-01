clear folder
folder.proj     = 'C:\PROJECTS\Subject_Studies\tACS_TMS_III\';
folder.code     = [folder.proj,'code\'];
folder.data     = [folder.proj,'dataset\'];
folder.cache    = [folder.proj,'cache\'];
folder.results  = [folder.proj,'results\'];
addpath(folder.code)

D = dir(folder.data);
D([1,2])  = [];
setup.subjects      = {D.name};
setup.chan.label    = {'EMG', 'tACS', 'EEG', 'trigger', 'time', 'sample'};
setup.chan.EEG      = ismember(setup.chan.label,'EEG');
setup.Fs            = 5000;
%%
clc
close all
figure
G = [];
count_idx = 0;
for sub_idx = 1 : length(setup.subjects)
        
    D = dir([folder.data,setup.subjects{sub_idx},'\data\loaded\*screening*RS_REST*.mat']);
    if length(D)<1, continue; end
    load([folder.data,setup.subjects{sub_idx},'\data\loaded\',D.name])        
    
    count_idx = count_idx + 1;
    subplot(3,4,count_idx),
    
    EEG_CHAN    = detrend(RS_REST.EEG(:,setup.chan.EEG));     
    [Pxx,gm]    = psdfit.fit_tab(EEG_CHAN,setup.Fs);
    psdfit.plot_tab(gm,Pxx);

    G(count_idx).gm     = gm;
    G(count_idx).g1     = g1;
    G(count_idx).g2     = g2;
    G(count_idx).Pxx    = Pxx;
    
end
