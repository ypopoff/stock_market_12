%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

function [ SS ] = volatilityFeedback( k, SS )
%   updates sigma value depending on past market volatility

    T = 599 + randi(5401);                  % determine time window

    baseIndex = SS.retsize - floor(T/60);            % calulate base index
    
    if baseIndex < 1
        
        baseIndex = 1;                      % take entire history into account
        
    end
   
    if SS.retsize > 0                       % we can only affect sigma once log returns are available!
    
    
   logRet = SS.ret(baseIndex:SS.retsize,2)./100;   % extract wanted vector from ret matrix

   sigmaT = std(logRet);               % determine the standard deviation of log returns in period T
                                    
   sigmaN = k * sigmaT;                % sigmaN is a function of sigmaT

   SS.sigma = sigmaN;                  % set new value for sigma
   
    end
    
end


