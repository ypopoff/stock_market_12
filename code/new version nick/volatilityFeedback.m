%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

function [ SS ] = volatilityFeedback( k, SS, i)
%   updates sigma value depending on past market volatility

    [ SS ] = logReturns( SS, i);            % get logReturns matrix

    T = 599 + randi(5401);                  % determine time window

    [n,~] = size(SS.ret);                   % get number of lines in ret matrix

    baseIndex = n - floor(T/60);            % calulate base index

    if baseIndex > 0
    
        logRet = SS.ret(baseIndex:end,2);   % extract wanted vector from ret matrix

        sigmaT = std(logRet);               % determine the standard deviation of log returns in period T
                                    
        sigmaN = k * sigmaT;                % sigmaN is a function of sigmaT

        SS.sigma = sigmaN;                  % set new value for sigma

    end

end


