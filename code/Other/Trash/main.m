%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market



%% Main function
%   Determines trading period and calls buyer or seller function to create
%   entries in the Stock Market book

tic;

clear all; clc; clf;

%% Reset of the random stream
s = RandStream('mt19937ar','Seed',0);
%RandStream.setDefaultStream(s);
RandStream.setGlobalStream(s);

%% Initialisation section

graphics;
init;


coeff = 1/(SS.M*SS.T)*100;
pe = -1;

tregB4 = SS.treg;                                                           % initial trader matrix used for comparison
tnumB4 = SS.tnum;


%% Simulation section
t = 1+round(exprnd(SS.lambda));                                             % time of first entry

%t = 3;

lrt = SS.dt;                                                                % used for log returns calculation intervals

for i = 1:1:(SS.M)*(SS.T)


    %% Age Update
    SS.bookbpaging = ageUpdate( SS.bookbpaging, SS.sbbp );
    SS.bookspaging = ageUpdate( SS.bookspaging, SS.sbsp );
    
    %% Calculate Log Returns    
    
    if i == lrt
        
        [ SS ] = logReturns( SS );                                          % calculate log returns        
        
        lrt = lrt + SS.dt;                                                     % increment lrt for next log returns calculation
        
    end
    
    
    %% New Book Entry Section
    if i == t
    
        Tau = 1+round(exprnd(SS.lambda));                                      %step between two book entries
                                                                               %(random number; exponential distribution
        SS.sd2 = SS.sd2 + 1;
        SS.debug( SS.sd2, 2 ) = Tau;
        
    
        t = t + Tau;
        if t - m * SS.T > SS.T                                                 % t - m * T = actual time in the trading day m
        

            m = m + 1;                                                         % increment number of days past
            m
            
            [ SS ] = emptyBook( SS );

        
        end
    
        
       
        %% Book entry
        
        ind = randi(SS.tnum, 1, 1);                                         % index of the chosen trader
        stat = randi(2, 1, 1) - 1;                                          % choose between buyer (0) or seller (1)
        
        arefresh = 0;                                                       % bit to tell whether the entry is new or refreshed
        orind = 0;                                                          % new auction: no aged entry line
        
        if stat == 0                                                        % we have a buy order (0)
        
            [ SS ] = buyer(SS, m, i, ind, arefresh, orind);
            
        else                                                                % we have a sell order (1)

            [ SS ] = seller(SS, m, i, ind, arefresh, orind);
            
        end

        
    end
    
    
    %% Age Check
    
    [ SS ] = ageCheckBuyer(SS, m, i);
    [ SS ] = ageCheckSeller(SS, m, i);


    [ SS ] = weightedTP( SS, i );                                           % update weighted transaction price matrix
    
    
    %% Plot section live
    liveplot = 1;                                                           % live plot on/off
    
    if liveplot == 1
        
        [ ymin, ymax ] = plotPrice( i, SS, ymin, ymax, fig1 );
        %plotLogReturns( SS, fig4 );
        
    end
    
    
    %% Percentage (evolution)
    npe = floor(coeff * i);
    if npe > pe
        
        pe = pe + 1;
        %clc;
        disp(['Completed to ', num2str(pe), ' percents!']);
        
    end
        
        
end

plotLogReturns( SS, fig4 );
[ ymin, ymax ] = plotPrice( i, SS, ymin, ymax, fig1 );
figure(5);
hist(SS.debug(1:SS.sd2,2));
figure(6);
hist(SS.debug(1:SS.sd3,3));
figure(7);
plot([ones(SS.sd1,1),SS.debug(1:SS.sd1,1)]);
ylim([0.0 0.2]);
sum(SS.debug(1:10,1))/10
sum(SS.debug(1:20,1))/20
sum(SS.debug(1:30,1))/30
sum(SS.debug(1:40,1))/40
figure(8);
hist(SS.treg(1:SS.tnum,1) + SS.p0 * SS.treg(1:SS.tnum,2));


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