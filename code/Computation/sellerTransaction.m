%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock mark

function [ SSM ] = sellerTransaction( SSM, SP, ind, shares, p, a0, t )
%SELLERTRANSACTION   Checks if a transaction should occur when a new seller
%   entry is created and carries it out if need be (eventually with
%   multiple buyers)

    if SSM.sbbp > 0
        
        %% Information fetch
        priceB = SSM.bookbpaging(1,1);                                      % maximum buy order unit price  
        
        pCounter = 1;                                                       % used if buyer index == seller index
        
        
        %% Transaction loop
        %   (until buyer no more money or price too high)
        while( p <= priceB && SSM.sbbp >= pCounter )                        % sellerTransaction -> price == bid price !
            
            priceB = SSM.bookbpaging(pCounter,1);                           % new maximum buy order unit price  
            EntryIndexB = SSM.bookbpaging(pCounter,4);                      % index of entry in bookb
            buyerID = SSM.bookb(EntryIndexB,3);                             % ID of the buyer
            
 
            %% Traders distinct
            if buyerID ~= ind

                sharesB = SSM.bookbpaging(pCounter,3);                      % desired number of shares for buyer

                
                %% Shares control
                %   buyer desires to buy shares but may already have given
                %   away his money due to a newer auction
                maxBshares = floor((SSM.treg(buyerID,1))/priceB);           % maximum number of shares buyer can buy

                if maxBshares < sharesB

                    sharesB = maxBshares;                                   % negative liquidities not allowed ! -> set to maximum allowed
                    warning('W01 Buyer lacks liquidities');

                end
                
                
                trshares = min(shares, sharesB);                            % amount of maximum shares involved in transaction
                trliq = priceB * trshares;                                  % cash involved

                %% Holdings update
                SSM.treg(buyerID,1) = SSM.treg(buyerID,1) - trliq;          % update buyer's account
                SSM.treg(buyerID,2) = SSM.treg(buyerID,2) + trshares;       % udpate buyer's share holdings

                SSM.treg(ind,1) = SSM.treg(ind,1) + trliq;                  % update seller's account
                SSM.treg(ind,2) = SSM.treg(ind,2) - trshares;               % update seller's share holdings
                
                %% Buyer book & paging buyer book update
                
                % buyer not bought all
                if sharesB > trshares
                
                    SSM.bookbpaging(pCounter,3) = sharesB - trshares;       % update buyer order shares
                    
                else
                    
                    SSM.bookbpaging(pCounter,:) = [];                       % delete buyer entry from paging book 
                    SSM.sbbp = SSM.sbbp - 1;                                % decrement number of entries in bookbpaging
                    SSM.bookb(EntryIndexB,6) = 0;                           % set dirty-bit to 0 in bookb
                    
                end
                
                
                %% Seller book update
                shares = shares - trshares;                                 % remaining seller shares (cannot be negative)

                if shares == 0
                
                    SSM.books(SSM.sbs, 6) = 0;                              % set valid bit to 0 in books
                    break;
                    
                end
                
                
                %% New entry in tprice
                SSM.sbp = SSM.sbp + 1;                                      % increment number of entries in tprice
                SSM.tprice(SSM.sbp,:) = [priceB, sharesB, ind, SSM.sbs, buyerID, EntryIndexB, t];
                
                
            else
                
                pCounter = pCounter + 1;                                    % skip trader next loop
                
            end
            
            
        end
        
    end
                
              
    %% Seller still desires to sell shares
    %   - New auction in books
    %   - If all the shares were sold, then no new entry in seller paging
    %     book
    if shares > 0
            
        SSM.sbsp = SSM.sbsp + 1;                                            % increment number of elements in paging book
        SSM.bookspaging( SSM.sbsp, : ) = [ p, t, shares, SSM.sbs, a0 ];     % new entry in the paging book
        SSM = sortBooks( SSM );                                             % sort the paging book
        
    end

end

