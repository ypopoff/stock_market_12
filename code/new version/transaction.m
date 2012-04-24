%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

function [ SS ] = transaction(SS, i)
% Checks if one or more transactions need to be executed
% Calls singleTransaction which executes a trade between two parties
% Updates all relevant variables

if(SS.sbsp ~= 0 && SS.sbbp ~= 0)     % % check that there are in fact entries in the paging books

    priceS = SS.bookspaging(1,1);                      % minimum sell order unit price
    
    priceB = SS.bookbpaging(1,1);                      % maximum buy order unit price
    
    EntryIndexS = SS.bookspaging(1,4);             	% index of entry in books
        
    EntryIndexB = SS.bookbpaging(1,4);                 % index of entry in bookb
          
    sellerID = SS.books(EntryIndexS,3);                % ID of the seller
        
    buyerID = SS.bookb(EntryIndexB,3);                 % ID of the buyer

    if(priceB >= priceS && sellerID ~= buyerID) % continue only if we have a price overlap and traders are distinct!
               
        sharesS = SS.bookspaging(1,3);                 % number of shares on sale from seller
       
        sharesB = SS.bookbpaging(1,3);                 % desired number of shares for buyer
                      
        if(sharesS == sharesB)    % -> we have one single transaction!
           
            SS.bookspaging(1,:) = [];                  % delete seller entry from paging book
            SS.books(EntryIndexS,6) = 0;               % set dirty-bit to 0 in books
            
            SS.bookbpaging(1,:) = [];                  % delete buyer entry from paging book
            SS.bookb(EntryIndexB,6) = 0;               % set dirty-bit to 0 in bookb
            
            SS.sbsp = SS.sbsp - 1;                        % decrement number of entries in bookspaging
            SS.sbbp = SS.sbbp - 1;                        % decrement number of entries in bookbpaging
            
            % transaction at seller's price!
            [ SS ] = singleTransaction(sellerID, buyerID, sharesS, priceS, SS, EntryIndexS, EntryIndexB, i); 
            
        end
    end
    
    if(sellerID == buyerID)
       
        % ToDo -> check other paging entries ?
        warning('sellerID = buyerID !!!');
        
    end
    

end

end

