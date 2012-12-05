%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

function [ p ] = regulatePrice( p, SP, t )
% Returns regulated price p using given price
%   regulation parameters

    pCeiling = SP.pC + (SP.growth*SP.pC/(100*24*60*60))*t;                             % calculate current price ceiling
    pFloor = SP.pF + (SP.growth*SP.pF/(100*24*60*60))*t;                               % calculate current price floor
    
    if p > pCeiling
        
        p = pCeiling;           % set price to nearest legal limit
        
    else
        if p < pFloor
            
            p = pFloor;         % set price to nearest legal limit
            
        end
        
    end

end

