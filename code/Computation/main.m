%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SSM, SP, SPL ] = main( SSM, SP, SPL )
%MAIN Determines trading period and calls buyer or seller function to create
%   entries in the Stock Market book


    % Liveplot
    if SPL.liveplot == 1
            
        cd('../Plot');
        
            liveplot;
            
        cd('../Computation');
        
    end
        

    % Debug coefficient: time evolution
    coeff = 1/(SP.M*SP.T)*100;
    pe = -1;
    
    % Function scope
    m = 0;

    %tic;

    %% Initialisation
    s = RandStream('mt19937ar','Seed',0);                                   % choosing & resetting random stream
    %RandStream.setDefaultStream(s);
    RandStream.setGlobalStream(s);
    
    t = 1+round(exprnd(SP.lambda));                                         % time of first entry
    lrt = SP.dt;                                                            % used for log returns calculation intervals


    %% Simulation section
    for i = 1:1:(SP.M)*(SP.T)

        
        %% Shift the mean
        SP = shiftMean( SP, m );
        

        %% Age Update
        SSM.bookbpaging = ageUpdate( SSM.bookbpaging, SSM.sbbp );
        SSM.bookspaging = ageUpdate( SSM.bookspaging, SSM.sbsp );

        %% Calculate Log Returns    
        if i == lrt

            [ SSM ] = logReturns( SSM, SP );                                % calculate log returns        

            lrt = lrt + SP.dt;                                              % increment lrt for next log returns calculation

        end


        %% New Book Entry Section
        if i == t

            Tau = 1+round(exprnd(SP.lambda));                               % step between two book entries
                                                                            % (random number; exponential distribution
                                                                            
            SSM.st = SSM.st + 1;                                            % saving event occurrence
            SSM.tocc( SSM.st, 1 ) = Tau;

            
            t = t + Tau;
            if t - m * SP.T > SP.T                                          % t - m * T = actual time in the trading day m


                m = m + 1;                                                  % increment number of days past

                [ SSM ] = emptyBook( SSM, SP );


            end



            %% Book entry
            ind = randi(SP.tnum, 1, 1);                                     % index of the chosen trader
            stat = randi(2, 1, 1) - 1;                                      % choose between buyer (0) or seller (1)

            arefresh = 0;                                                   % bit to tell whether the entry is new or refreshed
            orind = 0;                                                      % new auction: no aged entry line

            if stat == 0                                                    % we have a buy order (0)

                [ SSM ] = buyer(SSM, SP, m, i, ind, arefresh, orind);

            else                                                            % we have a sell order (1)

                [ SSM ] = seller(SSM, SP, m, i, ind, arefresh, orind);

            end


        end


        %% Age Check
        [ SSM ] = ageCheckBuyer(SSM, SP, m, i);
        [ SSM ] = ageCheckSeller(SSM, SP, m, i);


        [ SSM ] = weightedTP( SSM, i );                                           % update weighted transaction price matrix


        %% Plot section live
        if SPL.liveplot == 1

            cd('../Plot');
            plotPrice( i, SSM, SP, SPL, fig1 );
            cd('../Computation');

        end


        %% Percentage (evolution)
        npe = floor(coeff * i);
        if npe > pe

            pe = pe + 1;
            disp(['Completed to ', num2str(pe), ' percents!']);

        end


    end
    
    
    %% Control
    if sum(SSM.bookb(:,6)) ~= SSM.sbbp
        
        warning('W07 Buyer bookb & bookbpaging do not coincide!');
        
    end
    if sum(SSM.books(:,6)) ~= SSM.sbsp
        
        warning('W08 Seller books & bookspaging do not coincide!');
        
    end
    


    %ctime = toc;

end

