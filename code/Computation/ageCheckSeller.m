%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SSM ] = ageCheckSeller( SSM, SP, m, t )
%AGECHECKSELLER checks if the entry in the book is older than a0 (lifespan)
%   If aged: trader makes new offer


    %% Find bid to be refreshed 
    pagedind = find( SSM.bookspaging( [1:1:SSM.sbsp], 5 ) <= 0 );
    

    if isempty(pagedind) ~= 1 && SP.entage == 1
        
        lgt = length( pagedind );
    
        if lgt > 1                                                          % queue of traders who want to refresh auction
            
            warning('W06 Seller: Number of entries to be renewed: %d', lgt);
            
        end
        
    
        %just refresh the first element    
        %pagedind = pagedind(1);
        
        
        %% Get data from bid to be refreshed
        %   Book Format:
        %   day, time, seller/buyer id, s/b price, shares, dirty bit, age bit, new
        %   entry number, index of aged entry
        
        for i = 1:1:lgt
                                                                            % loop for each auction to be refreshed
        
            %orind = SS.bookspaging( i, 4 );                                % get original auction index
            orind = SSM.bookspaging( pagedind(i), 4 );                      % get original auction index
            
            auction = SSM.books( orind, : );   
            ind = auction(3);                                               % index of the chosen trader
            arefresh = auction(8) + 1;                                      % amount of refresh
            
            SSM.books( orind, [6, 7] ) = [0, 1]';                           % old entry invalid 
                                                                            % old entry aged
            SSM.bookspaging( pagedind(i), : ) = [];                         % erase old entry in paging matix
            SSM.sbsp = SSM.sbsp - 1;
            pagedind = pagedind(:,1) -1;                                    % update index of entries to renew (shifted due
                                                                            % to actual renewal)
            
            
            if SP.entrefresh == 1
            
                [ SSM ] = seller( SSM, SP, m, t, ind, arefresh, orind );
            
            end
            
        end
                
        
    end
    
end



