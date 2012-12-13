%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ] = comparePlot( SSM, SP, SPL, fig9 )
%COMPAREPLOT Plots the log returns, the price and the sigma versus time
%   Used for result comparison


    set( 0, 'CurrentFigure', fig9 );
    
    %% Log returns plot
    subplot(2,2,1);
    
    xmax = SP.M * SP.T;
    
    T = SP.dt:SP.dt:SP.dt*SSM.retsize;

    hold on;

    plot( T, SSM.ret(1:1:SSM.retsize,2));
    xlim([0 xmax]);
    ylim([SPL.retymin SPL.retymax]);
    xlabel('time in seconds', 'fontsize', SPL.xfs);
    ylabel('percent', 'fontsize', SPL.yfs);
    title('Log-returns', 'fontsize', SPL.tfs);


    for j = 1:1:SP.M

        line( [ j*SP.T j*SP.T ], [ SPL.retymin SPL.retymax ], 'Color', [0.75, 0.75, 0.75] );

    end

    hold off;
    
    %% Sigma plot
    subplot(2,2,2);

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
    
       
    
    %% Transaction price plot    
    [ SPL.ymin, SPL.ymax ] = dynamicLimity( SSM.pmax, SSM.pmin, SPL.ymin, SPL.ymax );

    xmax = SP.M * SP.T;

        
    %% Transaction price subplot
    subplot(2,2,[3 4]);
    hold on;

        Ap3 = [ 0; SSM.avgtprice( 1:1:int32(SSM.savtp), 2 ) ];
        Bp3 = [ SP.p0; SSM.avgtprice( 1:1:int32(SSM.savtp), 1 ) ];
        plot( Ap3, Bp3, 'r' );
            
    hold off;
            
        xlim([0 xmax]);
        ylim([SPL.ymin SPL.ymax]);
        xlabel('time in seconds', 'fontsize', SPL.xfs);
        ylabel('transaction price', 'fontsize', SPL.yfs);
        title('Transaction price', 'fontsize', SPL.tfs);
            
            
            
    %% Vertical day line

    for j = 1:1:SP.M
            
        subplot( 2, 2, [3 4] );
        line( [ j*SP.T j*SP.T ], [ SPL.ymin SPL.ymax ], 'Color', [0.75, 0.75, 0.75] );
            
    end



end

