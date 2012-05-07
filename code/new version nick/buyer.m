%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = buyer( SS, m, t, ind, arefresh, orind )
%buyer Completes the tasks of the buyer (stat = 0)
%   Calculates the price of the bid and executes the transaction if there
%   is a price overlap
        
        [ SS ] = volatilityFeedback( 1.5, SS );                           % account for past market volatility
        
        n = normrnd(SS.mu, SS.sigma, 1, 1);                                 %factor ni used to calculate price
        
        %if arefresh ~= 0
        
         %   n = SS.mu + abs( SS.mu - n );                                   %more interesting price: higher for buyer
            
        %end
        
        p = n * SS.d;                                                       %price of the bid - d = p0 for the first entry
        
        SS.d = p;                                                           %save latest entry price
       
        maxShares = floor((SS.treg(ind,1))/p);                              %maximum number of shares trader can buy
        
if maxShares > 0 && p > 0   % otherwise no order
    
        shares = randi(maxShares);                                          %random fraction of maximum
        
        
        %TODO maximal age
        a0 = 100;
          
        SS.sbb = SS.sbb + 1;                                                %increment number of elements in buy order book
        SS.bookb( SS.sbb, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ];  %new entry in buyer book
        
        [ SS ] = buyerTransaction( SS, ind, shares, p, a0, t );             % execute the order if possible
        
end
                   
end