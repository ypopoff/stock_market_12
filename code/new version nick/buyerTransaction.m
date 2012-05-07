%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock mark

function [ SS ] = buyerTransaction( SS, ind, shares, p, a0, t )
%   checks if a transaction should occur when a new buyer entry is
%   created and carries it out if need be (eventually with multiple sellers)

 if SS.sbsp > 0
        
        priceS = SS.bookspaging(1,1);                                   % minimum sell order unit price  
        
        EntryIndexS = SS.bookspaging(1,4);                               % index of entry in books
                  
        sellerID = SS.books(EntryIndexS,3);                               % ID of the seller
        
        pCounter = 1;                                                    % used if buyer index == seller index
        
        while(p >= priceS)  % buyerTransaction -> price == asking price !
        
        if sellerID ~= ind   % traders also have to be distinct !  
            
            sharesS = SS.bookspaging(pCounter,3);                        % desired number of shares for seller
                
            if sharesS > SS.treg(sellerID,2)
        
                sharesS = SS.treg(sellerID,2);                             % negative shares not allowed ! -> set to maximum allowed
                
            end
            
            if shares <= sharesS         % buy order will be completely filled
                
                amount = priceS * shares;                               % cash to debit / credit
                
                SS.treg(sellerID,1) = SS.treg(sellerID,1) + amount;      % update seller's account
                SS.treg(sellerID,2) = SS.treg(sellerID,2) - shares;      % udpate seller's share holdings
                
                SS.treg(ind,1) = SS.treg(ind,1) - amount;              % update buyer's account
                SS.treg(ind,2) = SS.treg(ind,2) + shares;              % update buyer's share holdings
                
                if shares == sharesS
                    
                    SS.bookspaging(pCounter,:) = [];                     % delete seller entry from paging book 
                    SS.books(EntryIndexS,6) = 0;                        % set dirty-bit to 0 in books
                    
                    SS.sbsp = SS.sbsp - 1;                              % decrement number of entries in bookspaging
                    
                else
                    SS.bookspaging(pCounter,3) = sharesS - shares;      % update seller order shares
                end               
                
                SS.bookb( SS.sbb, 6) = 0;                               % set dirty-bit to 0 in bookb
                
                % New entry in tprice
                SS.sbp = SS.sbp + 1;                                  % increment number of entries in tprice
        
                SS.tprice(SS.sbp,:) = [priceS, shares, sellerID, EntryIndexS, ind, SS.sbb, t];   
                
                shares = 0;                                             % set shares left to buy to 0
                
                break;  % order has been fully fulfilled
                
            else if shares > sharesS     % shares to buy are greater than shares to sell -> buy order will be partially filled
                
                amount = priceS * sharesS;                             % cash to debit / credit
                
                SS.treg(sellerID,1) = SS.treg(sellerID,1) + amount;      % update seller's account
                SS.treg(sellerID,2) = SS.treg(sellerID,2) - sharesS;      % udpate seller's share holdings
                
                SS.treg(ind,1) = SS.treg(ind,1) - amount;              % update buyer's account
                SS.treg(ind,2) = SS.treg(ind,2) + sharesS;              % update buyer's share holdings
                
                SS.bookspaging(pCounter,:) = [];                          % delete seller entry from paging book 
                SS.books(EntryIndexS,6) = 0;                        % set dirty-bit to 0 in books
                SS.sbsp = SS.sbsp - 1;                              % decrement number of entries in bookspaging
                
                % New entry in tprice
                SS.sbp = SS.sbp + 1;                                  % increment number of entries in tprice
        
                SS.tprice(SS.sbp,:) = [priceS, sharesS, sellerID, EntryIndexS, ind, SS.sbb, t];   
                
                    
                
               
                shares = shares - sharesS;                          % number of shares left to buy
                
                if SS.sbsp > pCounter
                
                priceS = SS.bookspaging(pCounter,1);                       % new minimum sell order unit price  
        
                EntryIndexS = SS.bookspaging(pCounter,4);                  % new index of entry in books
                  
                sellerID = SS.books(EntryIndexS,3);                  % new ID of the seller
                
                else
                    break;
                end
                end
            end
                
                               
        else % go to next seller
            
            if SS.sbsp > pCounter
            
            pCounter = pCounter + 1;                            % increment pCounter -> we skip over invalid buyerIDs
            
            priceS = SS.bookspaging(pCounter,1);                       % new mimimum sell order unit price  
        
            EntryIndexS = SS.bookspaging(pCounter,4);                  % new index of entry in books
                  
            sellerID = SS.books(EntryIndexS,3);                  % new ID of the seller
            
            else
                break;
            end
        end 
        
        end      % end of while loop -> bookbpaging needs to happen here !
 end     
        if shares > 0   % we didn't manage to buy all of the desired shares
            
            SS.sbbp = SS.sbbp + 1;                                          %increment number of elements in paging book
            SS.bookbpaging( SS.sbbp, : ) = [ p, t, shares, SS.sbb, a0 ];    %new entry in the paging book
            SS.bookbpaging = sortBookb( SS.bookbpaging, SS.sbbp );          % sort the paging book
        
        end

end

