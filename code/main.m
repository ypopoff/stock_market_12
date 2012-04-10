%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


clear all; clc;
%Main program
%   Determines trading period and calls buyer or seller function to create
%   entries in the Stock Market book

% TODO
% - comment code: matrix structure
% - implement transaction
% - sorting algorithm (by price, by time?)
% - volatility
% - limit order lifespan
% - maybe: create class: trader, with methods and variables -> interaction
%   object - oriented in MatLab?
% - returns plot (money made over money invested)
% - if statement for book emptying
% - saving and plotting coefficients n, tau & stat, to control the form of the
%   distribution, gaussian, exponential, resp. 50% distribution
% - optimize plots
% - maybe: save input values of the functions in matrixes (better overview?)
% - delete column 5 in books & bookb (status column)


%Initialisation section

init



%Simulation section

while m <= M 
    Tau = exprnd(lambda);                               %step between two book entries
                                                        %(random number; exponential distribution)
    
    t = t + Tau;
    if t - m * T > T                                    %t - m * T = actual time in the trading day m
        
        m = m + 1;                                      % increment number of days past
        bookb(1:1:sbb, :) = [];                         %book emptying
        sbb = 0;
        books(1:1:sbs, :) = [];
        sbs = 0;
        
    else
        
        ind = randi(tnum, 1, 1);                        %index of the chosen trader
        stat = randi(2, 1, 1) - 1;                      %choose between buyer (0) or seller (1)
        
        if stat == 0                                    %we have a buy order (0)
        
            [tprice, bookb, books, a, d, sbb, sbs, sbp] = buyer(bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice);
            
        else                                            %we have a sell order (1)

            [tprice, bookb, books, a, d, sbb, sbs, sbp] = seller(bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice);
            
        end
        
        
    end
    
end




%Plot section

%TO SOLVE: no plot because sbb & sbs = 0, books just emptied
%plot(bookb(1:1:sbb,4))
%plot(books(1:1:sbs,4))


%Plot transaction price over time
figure;
hold on;
plot(tprice(1:1:end, 3), tprice(1:1:end, 1), 'r');
xlim([0, max(tprice(1:1:end, 3))]);
ylim([min(tprice(1:1:end, 1)) - 1, max(tprice(1:1:end, 1)) + 1]);
xlabel('time');
ylabel('transaction price');
hold off;