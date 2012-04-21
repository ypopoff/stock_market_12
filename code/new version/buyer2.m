%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp ] = buyer2( bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, arefresh )
%buyer Completes the tasks of the buyer (stat = 0)
%   Calculates the price of the bid
%   Checks if transaction needs to be executed
%   Transaction executed

        n = normrnd(mu, sigma, 1, 1);                                       %factor ni used to calculate price
        p = n * d;                                                          %price of the bid
        
        %TODO amount of shares
        shares = 1;
          
        
        if solvabilityBuyer( treg, ind, p, shares ) == true
            
        
            sbb = sbb + 1;                                                  %increment number of elements in buy order book
            bookb( sbb,: ) = [ m, t, ind, p, shares, 1, 0, arefresh ];      %new entry in buyer book
            
            sbbp = sbbp + 1;                                                %increment number of elements in paging book
            bookbpaging( sbbp, : ) = [ p, shares, sbb ];                    %new entry in the paging book
            
            bookbpaging = sortbookb( bookbpaging, sbbp );                   %sorting the paging book
        
            multtransaction( bookbpaging, sbbp );
            
            
        else
            %call other trader
             
            
        end
       
        
end