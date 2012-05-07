%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = seller( SS, m, t, ind, arefresh, orind )
%seller Completes the tasks of the seller (stat = 1)
%   Calculates the asking price and executes the transaction if there if a
%   price overlap

        [ SS ] = volatilityFeedback( 1.5, SS );                           % account for past market volatility
              
        n = normrnd(SS.mu, SS.sigma, 1, 1);                                 %factor ni to calculate the price
        
        %if arefresh ~= 0
        
         %   n = SS.mu - abs( SS.mu - n );                                   %more interesting price: lower for seller
            
        %end
        
        p = n * SS.a;                                                       %asked price - a = a0 for the first entry
                           
        SS.a = p;                                                           %save latest entry price

if SS.treg(ind,2) > 0 && p > 0   % otherwise no order
        
        shares = randi(SS.treg(ind,2));                                     %random fraction of quantity of stocks owned by trader                               
        
        
        %TODO maximal age
        a0 = 100;
                                    
        SS.sbs = SS.sbs + 1;                                                 %increment number of elements in seller order book
        SS.books( SS.sbs, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ]; %new entry in seller book
     
        [ SS ] = sellerTransaction( SS, ind, shares, p, a0, t );            % execute the order if possible 
        
        
end
        
end