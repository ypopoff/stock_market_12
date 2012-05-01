function [ ymin, ymax ] = dynamicLimity( a, d, ymin, ymax )
%DYNAMICLIMITY computes the limit of the price graph
%   The limits adapt itself to the min & max price

    %TODO margin
    margin = 20;
        
        
    max1 = max( a, d ) + margin;
    min1 = min( a, d ) - margin;
        
    if max1 > ymax
            
        ymax = max1;
            
    end
        
        
    if min1 < ymin
            
        ymin = min1;
            
    end


end

