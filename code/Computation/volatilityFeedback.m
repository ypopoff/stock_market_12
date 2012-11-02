%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

function [ SSM ] = volatilityFeedback( SSM, SP, ind )
%   updates sigma value depending on past market volatility

    SSM.sd4 = SSM.sd4 + 1;
    
    %% Time window
    %   Randomly initialised for each trader
    %T = 599 + randi(5401);                                                 % determine time window
    T = SSM.treg( ind, 3 );
    
    baseIndex = SSM.retsize - floor(T/SP.dt);                               % calulate base index
    
    if baseIndex < 1
        
        baseIndex = 1;                                                      % take entire history into account
        
    end
   
    if SSM.retsize > 0                                                      % we can only affect sigma once log returns are available
    
        logRet = SSM.ret(baseIndex:SSM.retsize,2)./100;                     % extract wanted vector from ret matrix

        sigmaT = std(logRet);                                               % determine the standard deviation of log returns in period T 
        sigmaN = SP.k * sigmaT;                                             % sigmaN is a function of sigmaT


        SSM.sigma = SP.korrk * sigmaN + ( 1 - SP.korrk ) * SSM.sigma;       % set new value for sigma
        
        %% Evolution of sigma
        SSM.se = SSM.se + 1;
        SSM.sige( SSM.se, 1 ) = SSM.sigma;
   
    
    end
    
end


