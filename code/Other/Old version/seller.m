%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = seller( SS, m, t, ind, arefresh, orind )
%seller Completes the tasks of the seller (stat = 1)
%   Calculates the asking price and executes the transaction if there if a
%   price overlap

        volfeed = 1;

        if volfeed == 1
            
            [ SS ] = volatilityFeedback( SS, ind );                           % account for past market volatility
        
        end
        
        n = normrnd(SS.mu, SS.sigma, 1, 1);                                 %factor ni to calculate the price
        
        SS.sd3 = SS.sd3 + 1;
        SS.debug( SS.sd3, 3 ) = n;
        
        %if arefresh ~= 0
        
         %   n = SS.mu - abs( SS.mu - n );                                   %more interesting price: lower for seller
            
        %end
        
        %p = n * SS.a;                                                       %asked price - a = a0 for the first entry
%         p = SS.p0;
%         if SS.sbsp ~= 0
%             p = n * SS.bookspaging(SS.sbsp,1);
%         end

        korr = 1.0;
        if SS.sbsp ~= 0 && SS.sbbp ~= 0
            
            a = korr * SS.bookspaging(1, 1) + ( 1 - korr ) * SS.bookbpaging(1, 1);                                       %take actual best ask price in book a(th-1) 
            p = a * n;
           
        else
        
            if SS.sbp ~= 0
                
                %p = SS.tprice(SS.sbp, 1) * n;                                                   %if book empty, take last best price
                p = SS.a * n;
            
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
            
        
        
                    %if SS.a > p                                                         %update best seller price a(th)
                                                                                        %minimum function
                     %   SS.a = p;

                    %end


            if SS.treg(ind,2) > 0 && p > 0   % otherwise no order

                shares = randi(SS.treg(ind,2));                                     %random fraction of quantity of stocks owned by trader                               
                %shares = 1;

                %TODO maximal age
                a0 = 600;

                SS.sbs = SS.sbs + 1;                                                 %increment number of elements in seller order book
                SS.books( SS.sbs, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ]; %new entry in seller book

                [ SS ] = sellerTransaction( SS, ind, shares, p, a0, t );            % execute the order if possible 


            end
        
end