%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp ] = seller2( bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, arefresh )
%seller Completes the tasks of the seller (stat = 1)
%   Calculates the asking price
%   Checks if transaction needs to be executed
%   Transaction executed

        n = normrnd(mu, sigma, 1, 1);                                       %factor ni to calculate the price
        p = n * a;                                                          %asked price
        
        %TODO amount of shares
        shares = 1;                                                         %amount of shares
        

        if solvabilitySeller( treg, ind, shares ) == true
            
                            
            sbs = sbs + 1;                                                  %increment number of elements in buy order book
            books(sbs,:) = [ m, t, ind, p, shares, 1, 0, arefresh ];                  %new entry in seller book
            
            sbsp = sbsp + 1;                                                %increment number of elements in paging book
            bookspaging( sbsp, : ) = [ p, t, shares, sbs ];                 %new entry in the paging book
            
            bookspaging = sortBooks( bookspaging, sbsp );
            
            %TODO
            %multtransaction( bookspaging, sbsp );
  
            
        else
            %call other trader
            
            
            
        end