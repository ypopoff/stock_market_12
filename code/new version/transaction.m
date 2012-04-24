%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

function [tprice, bookb, books,sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp, fortune, fLen] = transaction(bookb, books,sbb , sbs, sbp, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, i, fortune, fLen, totShares)
% Checks if one or more transactions need to be executed
% Calls singleTransaction which executes a trade between two parties
% Updates all relevant variables

if(sbsp ~= 0 && sbbp ~= 0)     % % check that there are in fact entries in the paging books

    priceS = bookspaging(1,1);                      % minimum sell order unit price
    
    priceB = bookbpaging(1,1);                      % maximum buy order unit price
    
    EntryIndexS = bookspaging(1,4);             	% index of entry in books
        
    EntryIndexB = bookbpaging(1,4);                 % index of entry in bookb
          
    sellerID = books(EntryIndexS,3);                % ID of the seller
        
    buyerID = bookb(EntryIndexB,3);                 % ID of the buyer

    if(priceB >= priceS && sellerID ~= buyerID) % continue only if we have a price overlap and traders are distinct!
               
        sharesS = bookspaging(1,3);                 % number of shares on sale from seller
       
        sharesB = bookbpaging(1,3);                 % desired number of shares for buyer
                      
        if(sharesS == sharesB)    % -> we have one single transaction!
           
            bookspaging(1,:) = [];                  % delete seller entry from paging book
            books(EntryIndexS,6) = 0;               % set dirty-bit to 0 in books
            
            bookbpaging(1,:) = [];                  % delete buyer entry from paging book
            bookb(EntryIndexB,6) = 0;               % set dirty-bit to 0 in bookb
            
            sbsp = sbsp - 1;                        % decrement number of entries in bookspaging
            sbbp = sbbp - 1;                        % decrement number of entries in bookbpaging
            
            % transaction at seller's price!
            [tprice, treg, sbp] = singleTransaction(sellerID, buyerID, sharesS, priceS, treg, tprice, sbp, EntryIndexS, EntryIndexB, i); 
            
            fLen = fLen + 1;                        % increment number of entries in fortune
            
            fortune(fLen,:) = [i,totShares*priceS]; % add entry to fortune matrix
            
        end
    end
    
    if(sellerID == buyerID)
       
        % ToDo -> check other paging entries ?
        warning('sellerID = buyerID !!!');
        
    end
    

end

end

