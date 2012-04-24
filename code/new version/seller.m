%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp ] = seller( bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, arefresh, orind )
%seller Completes the tasks of the seller (stat = 1)
%   Calculates the asking price
%   Checks if transaction needs to be executed
%   Transaction executed
  

        n = normrnd(mu, sigma, 1, 1);                                       %factor ni to calculate the price
        p = n * a;                                                          %asked price - a = a0 for the first entry
        a = p;                                                              %save latest entry price
        
        %TODO amount of shares
        shares = 1;                                                         %amount of shares
        
        %TODO maximal age
        a0 = 600;
        

        if solvencySeller( treg, ind, shares ) == true
            
                            
            sbs = sbs + 1;                                                  %increment number of elements in buy order book
            books( sbs, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ]; %new entry in seller book
            
            sbsp = sbsp + 1;                                                %increment number of elements in paging book
            bookspaging( sbsp, : ) = [ p, t, shares, sbs, a0 ];             %new entry in the paging book
            
            bookspaging = sortBooks( bookspaging, sbsp );
  
            
        else
            %call other trader
            
            
            
        end