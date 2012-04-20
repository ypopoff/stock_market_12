%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ tprice, bookb, books, a, d, sbb, sbs, sbp, treg ] = buyer( bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice, treg )
%buyer Completes the tasks of the buyer (stat = 0)
%   Calculates the price of the bid
%   Checks if transaction needs to be executed
%   Transaction executed

        n = normrnd(mu, sigma, 1, 1);           %factor ni used to calculate price
        p = n*d;                                %price of the bid
            
        if sbs > 0 && p >= a                    %sell order book is not empty and bid price is greater than or equal to lowest asking price -> transaction
        
            id = find(books(:,4) == a);
            tm = books(id, 2);
            
            sellerID = books(id,3);
            
            books(id,:) = [];                   %delete best sell limit order in

	
	    % execute the transaction
	    treg = transaction( treg, a, 1, sellerID, ind); % treg is now updated !


                                                %seller book
            sbs = sbs - 1;                      %decrement number of elements in sell order book
            
            sbp = sbp + 1;                      %entry in tprice
            tprice(sbp,:) = [a, tm, t]; 
            
            if sbs > 0                          %minimum asking price update
                a = min(books(1:1:sbs,4));
            else
                a = p0;                         %reset initial price
            end  
            
        else
            
            sbb = sbb + 1;                      %increment number of elements in buy order book
            bookb(sbb,:) = [m, t, ind, p, 0];   %new entry in buyer book
           
            
            if p > d || sbb == 1                %update best buyer price
                d = p;
            end
        
        end


end
