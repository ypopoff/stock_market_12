%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ tprice, bookb, books, a, d, sbb, sbs, sbp ] = buyer( bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice )
%buyer Completes the tasks of the buyer (stat = 0)
%   Calculates the price of the bid
%   Checks if transaction needs to be executed
%   Transaction executed

        n = normrnd(mu, sigma, 1, 1);           %factor ni to calculate the price
        p = n*d;                                %price of the bid
            
        if sbs > 0 && p > a                     %transaction
        
            id = find(books(:,4) == a);
            tm = books(id, 2);
            books(id,:) = [];                   %delete best sell limit order in
                                                %seller book
            sbs = sbs - 1;
            
            sbp = sbp + 1;                      %entry in tprice
            tprice(sbp,:) = [a, tm, t];
            
            if sbs > 0                          %minimum seller price update
                a = min(books(1:1:sbs,4));
            else
                a = p0;
            end
            %TODO transaction
            
        else
            
            sbb = sbb + 1;
            bookb(sbb,:) = [m, t, ind, p, 0]; %new entry in buyer book
           
            
            if p > d || sbb == 1              %update best buyer price
                d = p;
            end
        
        end


end

