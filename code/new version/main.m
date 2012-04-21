%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


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


%% Main program
%   Determines trading period and calls buyer or seller function to create
%   entries in the Stock Market book

clear all; clc; clf;

%% Initialisation section

init

tregB4 = treg;                                          % initial trader matrix used for comparison


%% Simulation section

while m <= M 
    Tau = exprnd(lambda);                               %step between two book entries
                                                        %(random number; exponential distribution)
    
    t = t + Tau;
    if t - m * T > T                                    %t - m * T = actual time in the trading day m
        
        m = m + 1;                                      % increment number of days past
        
        if bkempty == 1
        
            bookb(1:1:sbb, :) = [];                         %book emptying
            sbb = 0;
            books(1:1:sbs, :) = [];
            sbs = 0;
            
        end;
        
    else
        
        ind = randi(tnum, 1, 1);                        %index of the chosen trader
        stat = randi(2, 1, 1) - 1;                      %choose between buyer (0) or seller (1)
        
        arefresh = 0;                                   %bit to tell whether the entry is new or refreshed
        
        if stat == 0                                    %we have a buy order (0)
        
            [tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp] = buyer(bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, arefresh);
            
        else                                            %we have a sell order (1)

            [tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp] = seller(bookb, books, a, d, mu, sigma, m, t, ind, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, arefresh);
            
        end;
        
        
    end;
    
end;



%% Plot section

%TO SOLVE: no plot because sbb & sbs = 0, books just emptied
%plot(bookb(1:1:sbb,4))
%plot(books(1:1:sbs,4))


%Plot section
figure(1)
hold on;
%plot(bookb(1:1:sbb,4))
%plot(books(1:1:sbs,4))
plot(tprice(1:1:end, 3), tprice(1:1:end, 1), 'r');
xlim([0, max(tprice(1:1:end, 3))]);
ylim([min(tprice(1:1:end, 1)) - 1, max(tprice(1:1:end, 1)) + 1]);
xlabel('time')
ylabel('transaction price')
%hist(book(:,5),2)

hold off;


%% Plot trader assets
figure(2)

subplot(2,2,1)

bar([1:1:tnum], tregB4(:,1))	% initial trader liquidities
xlabel('trader ID')
ylabel('initial trader liquidities')

subplot(2,2,2)

bar([1:1:tnum], tregB4(:,2))	% initial trader share holdings
xlabel('trader ID')
ylabel('initial trader share holdings')

subplot(2,2,3)

bar([1:1:tnum], treg(:,1))	% final trader liquidities
xlabel('trader ID')
ylabel('final trader liquidities')

subplot(2,2,4)

bar([1:1:tnum], treg(:,2))	% final trader share holdings
xlabel('trader ID')
ylabel('final trader share holdings')