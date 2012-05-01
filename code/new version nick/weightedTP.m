%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock mark

function [ SS ] = weightedTP( SS, i )
%   updates the weighted average transaction price matrix used for plotting

   index = SS.sbp;                                 % get number of elements in tprice
    
   if index > 0
       
        lastTtime = SS.tprice(index,7);                 % get the most recent transaction time
    
        if lastTtime == i    % only needs updating if a transaction has been carried out during the current loop
        
            % initialize totals
            totalV = 0;
            totalS = 0;
        
            while( index > 0 && SS.tprice(index,7) == i)
            
                totalS = totalS + SS.tprice(index,2);
                totalV = totalV + SS.tprice(index,1)*SS.tprice(index,2);           
            
                index = index - 1;                      % decrement index
            
            end
        
            avgP = totalV/totalS;                       % calculate weighted average
        
            SS.savtp = SS.savtp + 1;                    % increment number of elements in avgtprice
            SS.avgtprice(SS.savtp,:) = [avgP, i];       % add element to avgtprice        
        
        end

    end

end

