%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ] = plotAssets( SS, tregB4, tnumB4 )
%PLOTASSETS Plot trader assests & estimated firm value

    %% Plot trader assets

    subplot(3,2,1)

    bar(1:1:tnumB4, tregB4(:,1))                                          % initial trader liquidities
    xlabel('trader ID')
    ylabel('initial trader liquidities')

    subplot(3,2,2)

    bar(1:1:tnumB4, tregB4(:,2))                                          % initial trader share holdings
    xlabel('trader ID')
    ylabel('initial trader share holdings')

    subplot(3,2,3)

    bar(1:1:SS.tnum, SS.treg(:,1))                                        % final trader liquidities
    xlabel('trader ID')
    ylabel('final trader liquidities')

    subplot(3,2,4)

    bar(1:1:SS.tnum, SS.treg(:,2))                                        % final trader share holdings
    xlabel('trader ID')
    ylabel('final trader share holdings')
    
    
    %% Plot Estimated firm value

    subplot(3,2,[5 6])

    inds = (SS.sbp - mod(SS.sbp,3))/3;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %To Nick: caution! inds could be 0
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if inds ~= 0

        Value = [SS.totShares*SS.p0,SS.totShares*SS.tprice(inds,1),SS.totShares*SS.tprice(2*inds,1), SS.totShares*SS.tprice(SS.sbp,1)];

        bar([0,SS.tprice(inds,7),SS.tprice(2*inds,7), SS.tprice(SS.sbp,7)],Value)
        xlabel('time (s)')
        ylabel('estimated firm value')
        
    end

end

