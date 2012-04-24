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

tic;

clear all; clc; clf;

%% Initialisation section

init

tregB4 = treg;                                                              % initial trader matrix used for comparison



%% Simulation section
t = 1+round(exprnd(lambda));

figure(1);                                                                  %select figure for plot

for i = 1:1:M*T

    %% Age Update
    bookbpaging = ageUpdate( bookbpaging, sbbp );
    bookspaging = ageUpdate( bookspaging, sbsp );
    
    %% New Book Entry Section
    if i == t
    
        Tau = 1+round(exprnd(lambda));                                      %step between two book entries
                                                                            %(random number; exponential distribution)
    
        t = t + Tau;
        if t - m * T > T                                                    %t - m * T = actual time in the trading day m
        
            m = m + 1;                                                      % increment number of days past

            if bkempty == 1
            
                [ bookb, sbb, books, sbs ] = emptyBook( bookb, sbb, books, sbs );
                
            end
        
        end
    
        
       
        %% Book entry
        
        ind = randi(tnum, 1, 1);                                            %index of the chosen trader
        stat = randi(2, 1, 1) - 1;                                          %choose between buyer (0) or seller (1)
        
        arefresh = 0;                                                       %bit to tell whether the entry is new or refreshed
        orind = 0;                                                          %new auction: no aged entry line
        
        if stat == 0                                                        %we have a buy order (0)
        
            [tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp] = buyer(bookb, books, a, d, mu, sigma, m, i, ind, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, arefresh, orind );
            
        else                                                                %we have a sell order (1)

            [tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp] = seller(bookb, books, a, d, mu, sigma, m, i, ind, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, arefresh, orind );
            
        end

        
    end
    
    
    %% Age Check
        
    [tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp] = ageCheckBuyer(bookb, books, a, d, mu, sigma, m, i, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp);
    [tprice, bookb, books, a, d, sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp] = ageCheckSeller(bookb, books, a, d, mu, sigma, m, i, sbb, sbs, sbp, p0, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp);
        
    
    
    %% Transaction Section
    
    [tprice, bookb, books,sbb, sbs, sbp, treg, bookbpaging, sbbp, bookspaging, sbsp, fortune, fLen] = transaction(bookb, books,sbb , sbs, sbp, tprice, treg, bookbpaging, sbbp, bookspaging, sbsp, i, fortune, fLen, totShares);
    
    
    %% Plot section
    [ ymin, ymax ] = plotPrice( i, M, T, bookb, sbb, books, sbs, tprice, sbp, p0, a, d, ymin, ymax );
    
        
end



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

%% Plot Estimated firm fortune
figure(3)

plot(fortune(1:1:fLen,1), fortune(1:1:fLen,2))
xlabel('time')
ylabel('estimated firm fortune')

toc;