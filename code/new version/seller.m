%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = seller( SS, m, t, ind, arefresh, orind )
%seller Completes the tasks of the seller (stat = 1)
%   Calculates the asking price

        n = normrnd(SS.mu, SS.sigma, 1, 1);                                       %factor ni to calculate the price
        p = n * SS.a;                                                          %asked price - a = a0 for the first entry
        SS.a = p;                                                              %save latest entry price
        
        %TODO amount of shares
        shares = 1;                                                         %amount of shares
        
        %TODO maximal age
        a0 = 600;
        

        if solvencySeller( SS.treg, ind, shares ) == true
            
                            
            SS.sbs = SS.sbs + 1;                                                  %increment number of elements in buy order book
            SS.books( SS.sbs, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ]; %new entry in seller book
            
            SS.sbsp = SS.sbsp + 1;                                                %increment number of elements in paging book
            SS.bookspaging( SS.sbsp, : ) = [ p, t, shares, SS.sbs, a0 ];             %new entry in the paging book
            
            SS.bookspaging = sortBooks( SS.bookspaging, SS.sbsp );
                       
        else
            %call other trader
            % ToDo..
            
            
            
        end