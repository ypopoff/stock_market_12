%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = buyer( SS, m, t, ind, arefresh, orind )
%buyer Completes the tasks of the buyer (stat = 0)
%   Calculates the price of the bid
        
        n = normrnd(SS.mu, SS.sigma, 1, 1);               %factor ni used to calculate price
        p = n * SS.d;                                              %price of the bid - d = p0 for the first entry
        SS.d = p;                                                  %save latest entry price
        
        %TODO amount of shares
        shares = 1;
        
        %TODO maximal age
        a0 = 600;
          
        
        if solvencyBuyer( SS.treg, ind, p, shares ) == true            
        
            SS.sbb = SS.sbb + 1;                              %increment number of elements in buy order book
            SS.bookb( SS.sbb, : ) = [ m, t, ind, p, shares, 1, 0, arefresh, orind ];  %new entry in buyer book
            
            SS.sbbp = SS.sbbp + 1;                                                %increment number of elements in paging book
            SS.bookbpaging( SS.sbbp, : ) = [ p, t, shares, SS.sbb, a0 ];             %new entry in the paging book
            

            SS.bookbpaging = sortBookb( SS.bookbpaging, SS.sbbp );                   %sorting the paging book

        else
            % call other trader
            % ToDo..
             
            
        end
       
        
end