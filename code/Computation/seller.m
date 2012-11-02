%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SSM ] = seller( SSM, SP, m, t, ind, arefresh, orind )
%SELLER Completes the tasks of the seller (stat = 1)
%   Calculates the asking price and executes the transaction if there if a
%   price overlap


        if SP.volfeed == 1
            
            [ SSM ] = volatilityFeedback( SSM, SP, ind );                   % account for past market volatility
        
        end
        
        n = normrnd(SP.mu, SSM.sigma, 1, 1);                                % factor ni to calculate the price
        
        SSM.sd3 = SSM.sd3 + 1;
        SSM.debug( SSM.sd3, 3 ) = n;
        
        %if arefresh ~= 0
        
         %   n = SS.mu - abs( SS.mu - n );                                  % more interesting price: lower for seller
            
        %end
        
        %% New price in function of old price
        if SSM.sbsp ~= 0 && SSM.sbbp ~= 0
            
            a = SP.korrbs * SSM.bookspaging(1, 1) + ( 1 - SP.korrbs ) * SSM.bookbpaging(1, 1);
                                                                            % take actual best ask price in book a(th-1) 
            p = a * n;
           
        else
            
            % book empty but already transactions
            if SSM.sbp ~= 0
                
                %p = SS.tprice(SS.sbp, 1) * n;                              % if book empty, take last best price
                p = SSM.a * n;
            
            else
                
                p = SP.p0;
                
            end
            
            warning('W04 Seller book empty!');
            
        end
        
        %% Price regulation
        %   variations of more than varwidth are not allowed
        
        varwidth = 0.06*SSM.sigma/0.005;
        
        if SSM.sbp ~= 0
            
            tpr = SSM.tprice( SSM.sbp, 1 );
            
        else
            
            tpr = SP.p0;
            
        end
        
        highlim = ( 1 + varwidth ) * tpr;
        lowlim = ( 1 - varwidth ) * tpr;
        
        
        if p < lowlim || p > highlim
            
            p = tpr;
            
        end


        %% Transaction section
        %   Compute amount of shares (sell) & write entry in book 
        if SSM.treg(ind,2) > 0 && p > 0                                     % otherwise no order

            %% Maximum & minimum price ever occurred
            if p > SSM.pmax
                    
                SSM.pmax = p;
                    
            end
                    
            if p < SSM.pmin
                    
                SSM.pmin = p;
                    
            end
            
            %% Shares
            if SP.mulshares == 1
                
                shares = randi(SSM.treg(ind,2));                            % random fraction of quantity of stocks owned by trader                               
            
            else
                
                shares = 1;

            end
            

            SSM.sbs = SSM.sbs + 1;                                          % increment number of elements in seller order book
            SSM.books( SSM.sbs, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ];
                                                                            % new entry in seller book

            [ SSM ] = sellerTransaction( SSM, SP, ind, shares, p, SP.a0, t );
                                                                            % execute the order if possible 


        end
        
        
end