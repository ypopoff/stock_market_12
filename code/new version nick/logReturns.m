%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = logReturns( SS, i )
%LOGRETURNS computes log returns each dt = 60s
%   returns logreturns in the SS.ret matrix


%Matrix format:
%       Column 1            Column 2        (Time intervall)
% 1     price p. tick       log-ret         1   -  60s
% 2     price p. tick       log-ret         61  - 120s
% 3     price p. tick       log-ret         121 - 180s
% ...

     
    tindex = 1;
    dt = 60;
    b = SS.p0;
    SS.retsize = ceil( i / dt );
    SS.ret = zeros( SS.retsize, 2 );

    
    %% Find last tick (previous-tick interpolation
    a = SS.tprice( tindex, 7 );
    for tottime = 1:1:i

        if tottime == a

            b = SS.tprice( tindex, 1 );

            tindex = tindex + 1;
            a = SS.tprice( tindex, 7 );

        end

        SS.ret( ceil( tottime / dt ), 1 ) = b;  

    end


    %% Compute log-return
    % in percent
    for tindex = 2:1:SS.retsize
       SS.ret( tindex, 2 ) = 100 * log( SS.ret(tindex,1) / SS.ret(tindex-1,1) ); 

    end


end

