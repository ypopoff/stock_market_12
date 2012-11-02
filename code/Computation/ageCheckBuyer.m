%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SSM ] = ageCheckBuyer( SSM, SP, m, t )
%AGECHECKBUYER checks if the entry in the book is older than a0 (lifespan)
%   If aged: trader makes new offer


    %% Find auction to be refreshed    
    pagedind = find( SSM.bookbpaging( [1:1:SSM.sbbp], 5 ) <= 0 );
    

    if isempty(pagedind) ~= 1 && SP.entage == 1
        
        lgt = length( pagedind );
    
        if lgt > 1                                                          % queue of traders who want to refresh auction
            
            warning('W05 Buyer: Number of entries to be renewed: %d', lgt);
            
        end
        
    
        %just refresh the first element    
        %pagedind = pagedind(1);
        
        
        %% Get data from bid to be refreshed
        %   Book Format:
        %   day, time, seller/buyer id, s/b price, shares, dirty bit, age bit, new
        %   entry number, index of aged entry
        
        for i = 1:1:lgt
                                                                            % loop for each auction to be refreshed
            
            %orind = SS.bookbpaging( i, 4 );                                % get original auction index
            orind = SSM.bookbpaging( pagedind(i), 4 );                      % get original auction index
            
            auction = SSM.bookb( orind, : );   
            ind = auction(3);                                               % index of the chosen trader
            arefresh = auction(8) + 1;                                      % amount of refresh
            
            SSM.bookb( orind, [6, 7] ) = [0, 1]';                           % old entry invalid 
                                                                            % old entry aged
            SSM.bookbpaging( pagedind(i), : ) = [];                         % erase old entry in paging matix
            SSM.sbbp = SSM.sbbp - 1;
            pagedind = pagedind(:,1) -1;                                    % update index of entries to renew (shifted due
                                                                            % to actual renewal)
            

            if SP.entrefresh == 1
                
                [ SSM ] = buyer( SSM, SP, m, t, ind, arefresh, orind );
        
            end
            
        end
                
        
    end
    
end

