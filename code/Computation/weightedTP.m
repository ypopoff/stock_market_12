%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock mark

function [ SSM ] = weightedTP( SSM, i )
%WEIGHTEDTP Updates the weighted average transaction price matrix used for plotting

   index = SSM.sbp;                                                         % get number of elements in tprice
    
   if index > 0
       
        lastTtime = SSM.tprice(index,7);                                    % get the most recent transaction time
    
        if lastTtime == i                                                   % only needs updating if a transaction
                                                                            % has been carried out during the current loop
        
            % initialize totals
            totalV = 0;                                                     % total amount of money involved in transactions
                                                                            % at time i
            totalS = 0;                                                     % total amount of shares in transactions
        
            while( index > 0 && SSM.tprice(index,7) == i)
            
                totalS = totalS + SSM.tprice(index,2);
                totalV = totalV + SSM.tprice(index,1)*SSM.tprice(index,2);           
            
                index = index - 1;                                          % decrement index
            
            end
        
            avgP = totalV/totalS;                                           % calculate weighted average
        
            SSM.savtp = SSM.savtp + 1;                                      % increment number of elements in avgtprice
            SSM.avgtprice(SSM.savtp,:) = [avgP, i];                         % add element to avgtprice        
        
        end

    end

end

