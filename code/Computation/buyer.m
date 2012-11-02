%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SSM ] = buyer( SSM, SP, m, t, ind, arefresh, orind )
%BUYER Completes the tasks of the buyer (stat = 0)
%   Calculates the price of the bid and executes the transaction if there
%   is a price overlap

        
        if SP.volfeed == 1
        
            [ SSM ] = volatilityFeedback( SSM, SP, ind );                   % account for past market volatility
        
        end
        
        n = normrnd(SP.mu, SSM.sigma, 1, 1);                                % factor ni used to calculate price
        
        SSM.sd3 = SSM.sd3 + 1;
        SSM.debug( SSM.sd3, 3 ) = n; 
        
        %if arefresh ~= 0
        
         %   n = SS.mu + abs( SS.mu - n );                                  % more interesting price: higher for buyer
            
        %end

        
        %% Compute new price in function of old price
        if SSM.sbbp ~= 0 && SSM.sbsp ~= 0                                                     
            
            d = SP.korrbs * SSM.bookbpaging(1, 1) + ( 1 - SP.korrbs ) * SSM.bookspaging(1, 1);
                                                                            % take actual best bid price in book d(th-1)
            p = d * n;
            
        else
            
            % book empty but already transactions
            if SSM.sbp ~= 0
            
                %p = SS.tprice(SS.sbp, 1) * n;                              % if book empty, take last best price
                p = SSM.d * n;
            
            else
                
                p = SP.p0;
                
            end
            
            warning('W03 Buyer book empty!');
        
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
        %   Compute amount of shares (buy) & write entry in book
        maxShares = floor((SSM.treg(ind,1))/p);                             % maximum number of shares trader can buy

        if maxShares > 0 && p > 0                                           % otherwise no order
                
            %% Maximum & minimum price ever occurred
            if p > SSM.pmax
                    
                SSM.pmax = p;
                    
            end
                    
            if p < SSM.pmin
                    
                SSM.pmin = p;
                    
            end

            
            %% Shares
            if SP.mulshares == 1
                
                shares = randi(maxShares);                                  % random fraction of maximum
                
            else
                
                shares = 1;
                
            end
                                             

            SSM.sbb = SSM.sbb + 1;                                          % increment number of elements in buy order book
            SSM.bookb( SSM.sbb, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ];
                                                                            % new entry in buyer book

            [ SSM ] = buyerTransaction( SSM, SP, ind, shares, p, SP.a0, t );
                                                                            % execute the order if possible

        end

                   
end