%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = ageCheckBuyer(SS, m, t)
%ageCheckBuyer checks if the entry in the book is older than a0 (lifespan)
%   If aged: trader makes new offer


%% Find auction to be refreshed
        
    pagedind = find( SS.bookbpaging( [1:1:SS.sbbp], 5 ) <= 0 );
    
    
    if isempty(pagedind) ~= 1
        
        lgt = length( pagedind );
    
        if length( lgt ) > 1                                                %queue of traders who want to refresh auction
            warning('Debug', 'Number of entries to be renewed: %d', lgt);
            
        end
        
    
        %just refresh the first element    
        pagedind = pagedind(1);
        
        
        %% Get data from bid to be refreshed
        %   Book Format:
        %   day, time, seller/buyer id, s/b price, shares, dirty bit, age bit, new
        %   entry number, index of aged entry
        
        %for i = 1:1:lgt
                                                                            %loop for each auction to be refreshed
            
            %orind = SS.bookbpaging( i, 4 );                                 %get original auction index
            orind = SS.bookbpaging( pagedind, 4 );                          %get original auction index
            auction = SS.bookb( orind, : );   
            ind = auction(3);                                               %index of the chosen trader
            arefresh = auction(8) + 1;                                      %amount of refresh
            
            SS.bookb( orind, [6, 7] ) = [0, 1]';                            %old entry invalid 
                                                                            %old entry aged
            SS.bookbpaging( pagedind, : ) = [];                             %erase old entry in paging matix
            SS.sbbp = SS.sbbp - 1;
            
            [ SS ] = buyer(SS, m, t, ind, arefresh, orind, i);
        
            
        %end
                
        
    end
    
end

