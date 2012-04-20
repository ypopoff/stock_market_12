%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ tprice, bookb, books, a, d, sbb, sbs, sbp, treg ] = seller( bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice, treg )
%seller Completes the tasks of the seller (stat = 1)
%   Calculates the asking price
%   Checks if transaction needs to be executed
%   Transaction executed

        n = normrnd(mu, sigma, 1, 1);           %factor ni to calculate the price
        p = n*a;                                %asked price
            
        if sbb > 0 && p < d                     %transaction
                
            id = find(bookb(:,4) == d);
            tm = bookb(id, 2);
            
            buyerID = bookb(id,3);
            
            bookb(id,:) = [];                   %delete best buy limit order in



	    % execute the transaction
	    treg = transaction( treg, d, 1, ind, buyerID); % treg is now updated !



                                                %buyer book
            sbb = sbb - 1;
                
            sbp = sbp + 1;                      %entry in tprice
            tprice(sbp,:) = [d, tm, t];
                
            if sbb > 0                          %maximum buyer price update
                d = max(bookb(1:1:sbb,4));
            else
                d = p0;
            end
            %TODO transaction
                
        else
                
            sbs = sbs + 1;
            books(sbs,:) = [m, t, ind, p, 1]; %new entry in seller book

           
            if p < a || sbs == 1              %update best seller price
               a = p;
           end
            
       end

            
end