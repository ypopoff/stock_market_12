%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ] = plotLogReturns( SSM, SP, SPL, fig4 )
%PLOTLOGRETURNS Plots log-returns over time
%   Uses previous-tick interpolation

    set(0, 'CurrentFigure', fig4 );
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
    

end

