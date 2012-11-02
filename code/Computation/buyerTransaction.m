%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock mark

function [ SSM ] = buyerTransaction( SSM, SP, ind, shares, p, a0, t )
%BUYERTRANSACTION Checks if a transaction should occur when a new buyer
%   entry is created and carries it out if need be (eventually with
%   multiple sellers)

    if SSM.sbsp > 0
        
        %% Information fetch
        priceS = SSM.bookspaging(1,1);                                      % mimimum sell order unit price  
        
        pCounter = 1;                                                       % incremented when buyerid = sellerid
                                                                            % the seller is then skipped
        
        %% Transaction loop
        %   (until no more money or no more interesting auction)
        while( p >= priceS && SSM.sbsp >= pCounter )                        % buyerTransaction -> price == asking price !
            
            
            priceS = SSM.bookspaging(pCounter,1);                           % new mimimum sell order unit price  
            EntryIndexS = SSM.bookspaging(pCounter,4);                      % index of entry in books
            sellerID = SSM.books(EntryIndexS,3);                            % ID of the seller
            
            
            %% Both involved traders distinct
            if sellerID ~= ind 

                sharesS = SSM.bookspaging(pCounter,3);                      % desired number of shares for seller

                
                %% Shares control
                %   seller wants to sell shares but may have already sold
                %   some shares due to another transaction
                
                if sharesS > SSM.treg(sellerID,2)

                    sharesS = SSM.treg(sellerID,2);                         % negative shares not allowed ! -> set to maximum allowed
                    warning('W02 Seller lacks shares');

                end
                

                trshares = min(shares, sharesS);                            % amount of shares involved in transaction
                trliq = priceS * trshares;                                  % cash to debit / credit
                
                
                %% Holdings update
                SSM.treg(sellerID,1) = SSM.treg(sellerID,1) + trliq;        % update seller's account
                SSM.treg(sellerID,2) = SSM.treg(sellerID,2) - trshares;     % udpate seller's share holdings

                SSM.treg(ind,1) = SSM.treg(ind,1) - trliq;                  % update buyer's account
                SSM.treg(ind,2) = SSM.treg(ind,2) + trshares;               % update buyer's share holdings
                
                
                %% Seller book & paging seller book update
                
                % seller not sold all
                if sharesS > trshares
                
                    SSM.bookspaging(pCounter,3) = sharesS - trshares;       % update seller order shares    
                    
                else
                    
                    SSM.bookspaging(pCounter,:) = [];                       % delete seller entry from paging book
                    SSM.sbsp = SSM.sbsp - 1;
                    SSM.books(EntryIndexS,6) = 0;                           % set dirty-bit to 0 in books
                        
                end
                
               
                %% Buyer book update
                shares = shares - trshares;                                 % buyer remaining shares
                
                % buyer bought all
                if shares == 0

                    SSM.bookb(SSM.sbb, 6) = 0;                              % set valid bit to 0 in bookb
                    break;
                    
                end
                
                
                %% New entry in tprice
                SSM.sbp = SSM.sbp + 1;                                      % increment number of entries in tprice
                SSM.tprice(SSM.sbp,:) = [priceS, sharesS, sellerID, EntryIndexS, ind, SSM.sbb, t]; 
                
            
            else
                
                pCounter = pCounter + 1;                                    % skip trader next loop
                
            end
     
        
        end                                                                 % end of while loop
    
    end
    
    
    %% Buyer still desires shares
    %   - A new auction appears in the bookb
    %   - If the buyer has already bought all of the desired shares,
    %     then there is no new entry in the bookb paging
    if shares > 0
            
        SSM.sbbp = SSM.sbbp + 1;                                            % increment number of elements in paging book
        SSM.bookbpaging( SSM.sbbp, : ) = [ p, t, shares, SSM.sbb, a0 ];     % new entry in the paging book
        SSM = sortBookb( SSM );                                             % sort the paging book
        
    end

end


