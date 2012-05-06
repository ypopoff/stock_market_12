function [ SS ] = sellerTransaction( SS, ind, shares, p, a0, t )
%   checks if a transaction should occur when a new seller entry is
%   created and carries it out if need be (eventually with multiple buyers)

if SS.sbbp > 0
        
        priceB = SS.bookbpaging(1,1);                                   % maximum buy order unit price  
        
        EntryIndexB = SS.bookbpaging(1,4);                               % index of entry in bookb
                  
        buyerID = SS.bookb(EntryIndexB,3);                               % ID of the buyer
        
        pCounter = 1;                                                    % used if buyer index == seller index
        
        while(p <= priceB)  % sellerTransaction -> price == bid price !
        
        if buyerID ~= ind   % traders also have to be distinct !  
            
            sharesB = SS.bookbpaging(pCounter,3);                              % desired number of shares for buyer
                
            maxBshares = floor((SS.treg(buyerID,1))/priceB);            %maximum number of shares buyer can buy
                
            if maxBshares < sharesB
        
                sharesB = maxBshares;                                   % negative liquidities not allowed ! -> set to maximum allowed
                
            end
            
            if shares <= sharesB         % sell order will be completely filled
                
                amount = priceB * shares;                               % cash to debit / credit
                
                SS.treg(buyerID,1) = SS.treg(buyerID,1) - amount;      % update buyer's account
                SS.treg(buyerID,2) = SS.treg(buyerID,2) + shares;      % udpate buyer's share holdings
                
                SS.treg(ind,1) = SS.treg(ind,1) + amount;              % update seller's account
                SS.treg(ind,2) = SS.treg(ind,2) - shares;              % update seller's share holdings
                
                if shares == sharesB
                    
                    SS.bookbpaging(pCounter,:) = [];                          % delete buyer entry from paging book 
                    SS.bookb(EntryIndexB,6) = 0;                        % set dirty-bit to 0 in bookb
                    
                    SS.sbbp = SS.sbbp - 1;                              % decrement number of entries in bookbpaging
                    
                else
                    SS.bookbpaging(pCounter,3) = sharesB - shares;             % update buyer order shares
                end               
                
                SS.books( SS.sbs, 6) = 0;                               % set dirty-bit to 0 in books
                
                % New entry in tprice
                SS.sbp = SS.sbp + 1;                                  % increment number of entries in tprice
        
                SS.tprice(SS.sbp,:) = [priceB, shares, ind, SS.sbs, buyerID, EntryIndexB, t]; 
                
                
                shares = 0;                                             % set shares left to sell to 0
                
                break;  % order has been fully fulfilled
                
            else if shares > sharesB     % shares to sell are greater than shares to buy -> sell order will be partially filled
                
                amount = priceB * sharesB;                             % cash to debit / credit
                
                SS.treg(buyerID,1) = SS.treg(buyerID,1) - amount;      % update buyer's account
                SS.treg(buyerID,2) = SS.treg(buyerID,2) + sharesB;      % udpate buyer's share holdings
                
                SS.treg(ind,1) = SS.treg(ind,1) + amount;              % update seller's account
                SS.treg(ind,2) = SS.treg(ind,2) - sharesB;              % update seller's share holdings
                
                SS.bookbpaging(pCounter,:) = [];                          % delete buyer entry from paging book 
                SS.bookb(EntryIndexB,6) = 0;                        % set dirty-bit to 0 in bookb 
                SS.sbbp = SS.sbbp - 1;                              % decrement number of entries in bookbpaging
                
                % New entry in tprice
                SS.sbp = SS.sbp + 1;                                  % increment number of entries in tprice
        
                SS.tprice(SS.sbp,:) = [priceB, sharesB, ind, SS.sbs, buyerID, EntryIndexB, t]; 
                
               
                shares = shares - sharesB;                          % number of shares left to sell
                
                if SS.sbbp > pCounter
                
                priceB = SS.bookbpaging(pCounter,1);                       % new maximum buy order unit price  
        
                EntryIndexB = SS.bookbpaging(pCounter,4);                  % new index of entry in bookb
                  
                buyerID = SS.bookb(EntryIndexB,3);                  % new ID of the buyer
                
                else
                    break;
                end
                
                end
            end
                
                               
        else % go to next buyer
            
            if SS.sbbp > pCounter
            
            pCounter = pCounter + 1;                            % increment pCounter -> we skip over invalid buyerIDs
            
            priceB = SS.bookbpaging(pCounter,1);                       % new maximum buy order unit price  
        
            EntryIndexB = SS.bookbpaging(pCounter,4);                  % new index of entry in bookb
                  
            buyerID = SS.bookb(EntryIndexB,3);                  % new ID of the buyer
                
            else
                break;
            end
        end 
        
        end      % end of while loop -> bookspaging needs to happen here !


end

        if shares > 0   % we didn't manage to sell all of the desired shares
            
            SS.sbsp = SS.sbsp + 1;                                          %increment number of elements in paging book
            SS.bookspaging( SS.sbsp, : ) = [ p, t, shares, SS.sbs, a0 ];    %new entry in the paging book
            SS.bookspaging = sortBooks( SS.bookspaging, SS.sbsp );          % sort the paging book
        
        end

end

