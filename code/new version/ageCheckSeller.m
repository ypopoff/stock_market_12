%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp] = ageCheckSeller(bookb, books, a, d, mu, sigma, m, t, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp )
%ageCheckSeller checks if the entry in the book is older than a0 (lifespan)
%   If aged: trader makes new offer


%% Find auction to be refreshed
        
    pagedind = find( bookspaging( [1:1:sbsp], 5 ) <= 0 );
    
    
    if isempty(pagedind) ~= 1
    
        if length(pagedind) > 1                                             %queue of traders who want to refresh auction
            warning('Number of entries to be be renewed');
            
        end
        
    
        %just refresh the first element    
        pagedind = pagedind(1);
        
        
        %% Get data from auction to be refreshed
        %   Book Format:
        %   day, time, seller/buyer id, s/b price, shares, dirty bit, age bit, new
        %   entry number, index of aged entry
            
        orind = bookspaging( pagedind, 4 );                             %get original auction index
        auction = books( orind, : );   
        ind = auction(3);                                               %index of the chosen trader
        arefresh = auction(8) + 1;                                      %amount of refresh
            
        books( orind, [6, 7] ) = [0, 1]';                               %old entry invalid 
                                                                        %old entry aged
        bookspaging( pagedind, : ) = [];                                %erase old entry in paging matix
        sbsp = sbsp - 1;
            
        [tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp] = seller(bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, arefresh, orind);
                
        
    end
    
end



