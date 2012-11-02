%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ] = plotLogReturns( SS, fig4 )
%PLOTLOGRETURNS Plots log-returns over time
%   Uses previous-tick interpolation

    set(0, 'CurrentFigure', fig4 );
    xmax = SS.M * SS.T;
    SS.dt = 60;

    T = SS.dt:SS.dt:SS.dt*SS.retsize;

    hold on;
    ymax = 5;
    ymin = -5;

    plot( T, SS.ret(1:1:SS.retsize,2));
    xlim([0 xmax]);
    ylim([ymin ymax]);
    xlabel('time in seconds');
    ylabel('percent');
    title('Log-returns');


    for j = 1:1:SS.M

        line( [ j*SS.T j*SS.T ], [ ymin ymax ], 'Color', [0.75, 0.75, 0.75] );

    end

    hold off;
    

end

