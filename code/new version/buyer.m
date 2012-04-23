%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp ] = buyer( bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, arefresh, orind )
%buyer Completes the tasks of the buyer (stat = 0)
%   Calculates the price of the bid
%   Checks if transaction needs to be executed
%   Transaction executed

        n = normrnd(mu, sigma, 1, 1);                                       %factor ni used to calculate price
        p = n * d;                                                          %price of the bid
        
        %TODO amount of shares
        shares = 1;
        
        %TODO maximal age
        a0 = 100;
          
        
        if solvencyBuyer( treg, ind, p, shares ) == true
            
        
            sbb = sbb + 1;                                                  %increment number of elements in buy order book
            bookb( sbb, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ];  %new entry in buyer book
            
            sbbp = sbbp + 1;                                                %increment number of elements in paging book
            bookbpaging( sbbp, : ) = [ p, t, shares, sbb, a0 ];             %new entry in the paging book
            
            bookbpaging = sortBookb( bookbpaging, sbbp );                   %sorting the paging book
        
            %TODO
            %multtransaction( bookbpaging, sbbp );
            
            
        else
            %call other trader
             
            
        end
       
        
end