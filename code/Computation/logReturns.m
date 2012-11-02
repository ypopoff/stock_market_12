%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SSM ] = logReturns( SSM, SP )
%LOGRETURNS computes log returns each dt = 60s
%   returns logreturns in the SSM.ret matrix


%Matrix format:
%       Column 1            Column 2        (Time intervall)
% 1     price p. tick       log-ret         1   -  60s
% 2     price p. tick       log-ret         61  - 120s
% 3     price p. tick       log-ret         121 - 180s
% ...

     
    tindex = SSM.sbp; 
    
    SSM.retsize = SSM.retsize + 1;                                          % increment retsize
    
   
    %% Find last tick (previous-tick interpolation)
    if tindex > 0                                                           % we have transaction values
    
        SSM.ret(SSM.retsize,1) = SSM.tprice( tindex, 1 );                   % write tick price into matrix


        %% Compute log-return
        % in percent
    
        if SSM.retsize > 1

            SSM.ret(SSM.retsize, 2) = 100 * log(SSM.ret(SSM.retsize,1) / SSM.ret(SSM.retsize - 1,1) ); 
       
        else
            
            SSM.ret(SSM.retsize, 2) = 0;                                    % set return to zero if we don't have enough entries
        
        end

    
    else
        
        SSM.ret(SSM.retsize, 1) = SP.p0;                                    % use initial price if no transactions have occured (previous tick ?)
        SSM.ret(SSM.retsize, 2) = 0;                                        % set return to zero (nothing has changed yet!)

    end
  
  

end



