%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ] = plotAssets( SSM, SP, SPL )
%PLOTASSETS Plot trader assests & estimated firm value

    %% Plot trader assets

    subplot(3,2,1)

    bar(1:1:SPL.tnumB4, SPL.tregB4(:,1))                                    % initial trader liquidities
    xlabel('trader ID', 'fontsize', SPL.xfs);
    ylabel('initial trader liquidities', 'fontsize', SPL.yfs);

    subplot(3,2,2)

    bar(1:1:SPL.tnumB4, SPL.tregB4(:,2))                                    % initial trader share holdings
    xlabel('trader ID', 'fontsize', SPL.xfs);
    ylabel('initial trader share holdings', 'fontsize', SPL.yfs);

    subplot(3,2,3)

    bar(1:1:SP.tnum, SSM.treg(:,1))                                         % final trader liquidities
    xlabel('trader ID', 'fontsize', SPL.xfs);
    ylabel('final trader liquidities', 'fontsize', SPL.yfs);

    subplot(3,2,4)

    bar(1:1:SP.tnum, SSM.treg(:,2))                                         % final trader share holdings
    xlabel('trader ID', 'fontsize', SPL.xfs);
    ylabel('final trader share holdings', 'fontsize', SPL.yfs);
    
    
    %% Plot Estimated firm value

    subplot(3,2,[5 6])

    inds = 1 + (SSM.savtp - mod(SSM.savtp,3))/3;
    
    Value = [SP.totShares*SP.p0,SP.totShares*SSM.avgtprice(inds,1),SP.totShares*SSM.avgtprice(2*inds,1), SP.totShares*SSM.avgtprice(SSM.savtp,1)];

    bar([0,SSM.avgtprice(inds,2),SSM.avgtprice(2*inds,2), SSM.avgtprice(SSM.savtp,2)],Value)
    xlabel('time (s)', 'fontsize', SPL.xfs);
    ylabel('estimated firm value', 'fontsize', SPL.yfs);
        

end