%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = buyer( SS, m, t, ind, arefresh, orind )
%buyer Completes the tasks of the buyer (stat = 0)
%   Calculates the price of the bid and executes the transaction if there
%   is a price overlap

        volfeed = 1;
        
        if volfeed == 1
        
            [ SS ] = volatilityFeedback( SS, ind );                           % account for past market volatility
        
        end
        
        n = normrnd(SS.mu, SS.sigma, 1, 1);                                 %factor ni used to calculate price
        
        SS.sd3 = SS.sd3 + 1;
        SS.debug( SS.sd3, 3 ) = n; 
        
        %if arefresh ~= 0
        
         %   n = SS.mu + abs( SS.mu - n );                                   %more interesting price: higher for buyer
            
        %end
        
        %p = n * SS.d;                                                       %price of the bid - d = p0 for the first entry
%         p = SS.p0;
%         if SS.sbbp ~= 0
%             p = n * SS.bookbpaging(SS.sbbp,1);
%         end

        korr = 1.0;
        if SS.sbbp ~= 0 && SS.sbsp ~= 0                                                     
            
            d = korr * SS.bookbpaging(1, 1) + ( 1 - korr ) * SS.bookspaging(1, 1);                                       %take actual best bid price in book d(th-1)
            p = d * n;
            
        else
            
            if SS.sbp ~= 0
            
                %p = SS.tprice(SS.sbp, 1) * n;                                                   %if book empty, take last best price
                p = SS.d * n;
           
            else
                
                p = SS.p0;
                
            end
            warning('book empty!');
        
        end
        
        
        %% Price regulation
        % variations of more than varwidth are not allowed
        
        varwidth = 0.06*SS.sigma/0.005;
        
        if SS.sbp ~= 0
            
            tpr = SS.tprice( SS.sbp, 1 );
            
        else
            
            tpr = SS.p0;
            
        end
        
        highlim = ( 1 + varwidth ) * tpr;
        lowlim = ( 1 - varwidth ) * tpr;
        
        if p < lowlim || p > highlim
            
            p = tpr;
            
        end

        
                    %if SS.d < p                                                         %update best buyer price d(th)
                                                                                        %maximum function
                        %SS.d = p;

                    %end

                    maxShares = floor((SS.treg(ind,1))/p);                              %maximum number of shares trader can buy

            if maxShares > 0 && p > 0   % otherwise no order

                shares = randi(maxShares);                                          %random fraction of maximum
                %shares = 1;

                %TODO maximal age
                a0 = 600;

                SS.sbb = SS.sbb + 1;                                                %increment number of elements in buy order book
                SS.bookb( SS.sbb, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ];  %new entry in buyer book

                [ SS ] = buyerTransaction( SS, ind, shares, p, a0, t );             % execute the order if possible

            end

                   
end