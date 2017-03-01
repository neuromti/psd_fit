function plot_tab(gm,Pxx)
    g1   = psdfit.calc_noisefloor(gm);
    g2   = psdfit.calc_powerpeaks(gm);
   % figure,  
    hold on
    plot(Pxx,'color',[.8 .8 .8])
    plot(g1,'color','b')
    plot(g1+g2,'color','r')   
    
    FOI         = psdfit.get_foi();
    FOI_SCALE   = mean(diff(FOI));
    title(['\theta:',num2str(gm.u1*FOI_SCALE),' \alpha:',num2str(gm.u2*FOI_SCALE),' \beta :',num2str(gm.u3*FOI_SCALE)])    
    set(gca,'XTICK',[0:5/FOI_SCALE:length(FOI)+1],'XTICKLABEL',[0:5:length(FOI)+1])
    set(gca,'XLIM',[0 length(FOI)+1],'YLIM',[0 1])