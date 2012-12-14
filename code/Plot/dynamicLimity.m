%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ymin, ymax ] = dynamicLimity( pmax, pmin, ymin, ymax )
%DYNAMICLIMITY computes the limit of the price graph
%   The limits adapt itself to the min & max price

    margin = 20;
        
        
    max1 = pmax + margin;
    min1 = pmin - margin;
        
    if max1 > ymax
            
        ymax = max1;
            
    end
        
        
    if min1 < ymin
            
        ymin = min1;
            
    end


end

