%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ] = plotCall( SSM, SP, SPL, plotpath, comparepath )
%PLOTCALL Calls the different plotting functions

    
    graphics;



    i = SP.M * SP.T;                                                        % ending time

    %% Evolution of price
    [ SPL ] = plotPrice( i, SSM, SP, SPL, fig1 );
    
    
    %% Assets
    set( 0, 'CurrentFigure', fig2 );
    plotAssets( SSM, SP, SPL );
    
    
    %% Log returns
    plotLogReturns( SSM, SP, SPL, fig4 );
    
    
    %% Evolution of occurrence
    set( 0, 'CurrentFigure', fig5 );
    hist(SSM.tocc(1:SSM.st,1));
    xlabel('time b/t 2 occurences', 'fontsize', SPL.xfs);
    ylabel('amount of occurences', 'fontsize', SPL.yfs);
    title('Trade occrrence', 'fontsize', SPL.tfs);

    
    %% Evolution of the normal distribution
    set( 0, 'CurrentFigure', fig6 );
    hist(SSM.debug(1:SSM.sd3,3));
    
    xlabel('price coefficient', 'fontsize', SPL.xfs);
    ylabel('amount', 'fontsize', SPL.yfs);
    title('Price distribution', 'fontsize', SPL.tfs);

    
    %% Evolution of sigma
    set( 0, 'CurrentFigure', fig7 );
    if SP.volfeed == 0
        plot([ones(SP.M*SP.T,1),SSM.sigma * ones(SP.M*SP.T,1)]);
        xlim([0 SP.M*SP.T]);
        xlabel('time in seconds', 'fontsize', SPL.xfs);
    
        for j = 1:1:SP.M

            line( [ j*SP.T j*SP.T ], [ 0.0 0.2 ], 'Color', [0.75, 0.75, 0.75] );

        end
        
    else
        plot([ones(SSM.se,1),SSM.sige(1:SSM.se,1)]);
        xlim([0 SSM.se]);
        xlabel('time (trading occurence)', 'fontsize', SPL.xfs);
    end
    ylim([0.0 0.2]);
    title('Sigma', 'fontsize', SPL.tfs);
    ylabel('sigma', 'fontsize', SPL.yfs);
    

    
    %% Wealth of taders
    set( 0, 'CurrentFigure', fig8 );
    hist(SSM.treg(1:SP.tnum,1) + SP.p0 * SSM.treg(1:SP.tnum,2));
    
    xlabel('total wealth (liquidities + price * shares)', 'fontsize', SPL.xfs);
    ylabel('amount', 'fontsize', SPL.yfs);
    title('Wealth of the traders', 'fontsize', SPL.tfs);
    

    %% Debug info
    Ubooks = unique(SSM.books(1:1:SSM.sbs,2));
    length(Ubooks);
    SSM.sbs;
    Ubookb = unique(SSM.bookb(1:1:SSM.sbb,2));
    length(Ubookb);
    SSM.sbb;
    
    %% Compare plot
    comparePlot(SSM, SP, SPL, fig9);
    
    
    %% Saving section
    cd('../');
    
        if SPL.ymax < 400
            figname = sprintf('%sprice', comparepath );
            saveas(fig9, figname, 'png' );
        end
        

        figname = sprintf('%sprice', plotpath );
        saveas(fig1, figname, 'png' );
    
        figname = sprintf('%sassets', plotpath );
        saveas(fig2, figname, 'png' );
    
        figname = sprintf('%slogreturns', plotpath );
        saveas(fig4, figname, 'png' );

        figname = sprintf('%seventocc', plotpath );
        saveas(fig5, figname, 'png' );
    
        figname = sprintf('%spricedist', plotpath );
        saveas(fig6, figname, 'png' );
    
        figname = sprintf('%ssigma', plotpath );
        saveas(fig7, figname, 'png' );
    
        figname = sprintf('%swealth', plotpath );
        saveas(fig8, figname, 'png' );
    
    cd('Plot/');


end

