%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = seller( SS, m, t, ind, arefresh, orind, i )
%seller Completes the tasks of the seller (stat = 1)
%   Calculates the asking price and executes the transaction if there if a
%   price overlap

        %[ SS ] = volatilityFeedback( 1.5, SS, i);                           % account for past market volatility

        n = normrnd(SS.mu, SS.sigma, 1, 1);                                 %factor ni to calculate the price
        
        %if arefresh ~= 0
        
         %   n = SS.mu - abs( SS.mu - n );                                   %more interesting price: lower for seller
            
        %end
        
        p = n * SS.a;                                                       %asked price - a = a0 for the first entry
        
        SS.a = p;                                                           %save latest entry price

if SS.treg(ind,2) > 0   % otherwise no order
        
        shares = randi(SS.treg(ind,2));                                     %random fraction of quantity of stocks owned by trader                               
        
        
        %TODO maximal age
        a0 = 100;
                                    
        SS.sbs = SS.sbs + 1;                                            %increment number of elements in seller order book
        SS.books( SS.sbs, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ]; %new entry in seller book

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
        
end