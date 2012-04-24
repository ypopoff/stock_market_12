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

graphics;
init;

tregB4 = SS.treg;                                                           % initial trader matrix used for comparison
tnumB4 = SS.tnum;


%% Simulation section
t = 1+round(exprnd(SS.lambda));

for i = 1:1:(SS.M)*(SS.T)


    %% Age Update
    SS.bookbpaging = ageUpdate( SS.bookbpaging, SS.sbbp );
    SS.bookspaging = ageUpdate( SS.bookspaging, SS.sbsp );
    
    
    %% New Book Entry Section
    if i == t
    
        Tau = 1+round(exprnd(SS.lambda));                                      %step between two book entries
                                                                               %(random number; exponential distribution)
    
        t = t + Tau;
        if t - m * SS.T > SS.T                                                 %t - m * T = actual time in the trading day m
        

            m = m + 1;                                                         % increment number of days past
        
            [ SS ] = emptyBook( SS );

        
        end
    
        
       
        %% Book entry
        
        ind = randi(SS.tnum, 1, 1);                                         %index of the chosen trader
        stat = randi(2, 1, 1) - 1;                                          %choose between buyer (0) or seller (1)
        
        arefresh = 0;                                                       %bit to tell whether the entry is new or refreshed
        orind = 0;                                                          %new auction: no aged entry line
        
        if stat == 0                                                        %we have a buy order (0)
        
            [ SS ] = buyer(SS, m, i, ind, arefresh, orind );
            
        else                                                                %we have a sell order (1)

            [ SS ] = seller(SS, m, i, ind, arefresh, orind );
            
        end

        
    end
    
    
    %% Age Check

    [ SS ] = ageCheckBuyer(SS, m, i);
    [ SS ] = ageCheckSeller(SS, m, i);


    %% Transaction Section
    
    [ SS ] = transaction(SS, i);
    
    
    %% Plot section live
    
    [ ymin, ymax ] = plotPrice( i, SS, ymin, ymax, fig1 );
        
        
end



%% Plot section result
set( 0, 'CurrentFigure', fig2 );
plotAssets( SS, tregB4, tnumB4 );

Ubooks = unique(SS.books(1:1:SS.sbs,2));
length(Ubooks)
SS.sbs
Ubookb = unique(SS.bookb(1:1:SS.sbb,2));
length(Ubookb)
SS.sbb

toc;