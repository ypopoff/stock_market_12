        set(gcf,'doublebuffer','on') ; % remove flicker
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

tregB4 = SS.treg;                                                              % initial trader matrix used for comparison
tnumB4 = SS.tnum;

%% Simulation section
t = 1+round(exprnd(SS.lambda));

for i = 1:1:(SS.M)*(SS.T)
    %disp('Actual time: ');
    %i
    %% Age Update
    SS.bookbpaging = ageUpdate( SS.bookbpaging, SS.sbbp );
    SS.bookspaging = ageUpdate( SS.bookspaging, SS.sbsp );
    
    %% New Book Entry Section
    if i == t
    
        Tau = 1+round(exprnd(SS.lambda));                                      %step between two book entries
                                                                               %(random number; exponential distribution)
    
        t = t + Tau;
        if t - m * T > T                                                       %t - m * T = actual time in the trading day m
        
            m = m + 1;                                                         % increment number of days past
        
            [ SS ] = emptyBook( SS );
        
        end
    
        
       
        %% Book entry
        
        ind = randi(SS.tnum, 1, 1);                                            %index of the chosen trader
        stat = randi(2, 1, 1) - 1;                                          %choose between buyer (0) or seller (1)
        
        arefresh = 0;                                                       %bit to tell whether the entry is new or refreshed
        orind = 0;                                                          %new auction: no aged entry line
        
        if stat == 0                                                        %we have a buy order (0)
        
            [ SS ] = buyer(SS, m, i, ind, arefresh, orind );
            
        else                                                                %we have a sell order (1)

            [ SS ] = seller(SS, m, i, ind, arefresh, orind );
            
        end

        
    else   
        %% Age Check
        
        [ SS ] = ageCheckBuyer(SS, m, i);
        [ SS ] = ageCheckSeller(SS, m, i);
        
    end
    
    plotPrice( i, SS );

    %% Transaction Section
    
        [ SS ] = transaction(SS, i);
        
        
end



%% Plot section
plotPrice( i, SS);



%% Plot trader assets
figure(2)

subplot(3,2,1)

bar([1:1:tnumB4], tregB4(:,1))	% initial trader liquidities
xlabel('trader ID')
ylabel('initial trader liquidities')

subplot(3,2,2)

bar([1:1:tnumB4], tregB4(:,2))	% initial trader share holdings
xlabel('trader ID')
ylabel('initial trader share holdings')

subplot(3,2,3)

bar([1:1:SS.tnum], SS.treg(:,1))	% final trader liquidities
xlabel('trader ID')
ylabel('final trader liquidities')

subplot(3,2,4)

bar([1:1:SS.tnum], SS.treg(:,2))	% final trader share holdings
xlabel('trader ID')
ylabel('final trader share holdings')

%% Plot Estimated firm value

subplot(3,2,[5 6])

inds = (SS.sbp - mod(SS.sbp,3))/3;



Value = [SS.totShares*SS.p0,SS.totShares*SS.tprice(inds,1),SS.totShares*SS.tprice(2*inds,1), SS.totShares*SS.tprice(SS.sbp,1)];

bar([0,SS.tprice(inds,7),SS.tprice(2*inds,7), SS.tprice(SS.sbp,7)],Value)
xlabel('time (s)')
ylabel('estimated firm value')

toc;