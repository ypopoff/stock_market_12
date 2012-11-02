%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

function [ SS ] = volatilityFeedback( SS, ind )
%   updates sigma value depending on past market volatility

    SS.sd4 = SS.sd4 + 1;
    
    %T = 599 + randi(5401);                  % determine time window
    T = SS.treg( ind, 3 );
    
    baseIndex = SS.retsize - floor(T/60);            % calulate base index
    
    if baseIndex < 1
        
        baseIndex = 1;                      % take entire history into account
        
    end
   
    if SS.retsize > 0                       % we can only affect sigma once log returns are available!
    
        logRet = SS.ret(baseIndex:SS.retsize,2)./100;   % extract wanted vector from ret matrix

        sigmaT = std(logRet);               % determine the standard deviation of log returns in period T
        


        k = 1.5;
        sigmaN = k * sigmaT ;                % sigmaN is a function of sigmaT
        %korr = 0.001;
        %korr = 0.00085;
        korr = 0.0004
        
        %if sigmaN > SS.sigma                % does this make sense ?

            SS.sigma = korr * sigmaN + ( 1 - korr ) * SS.sigma;                  % set new value for sigma

        %else
            %SS.sigma = SS.sigma;                % back to initial value
        %end
        
        %SS.sigma = 0.003 + round(SS.sd4/40)*0.001
        
        SS.sd1 = SS.sd1 + 1;
        SS.debug( SS.sd1, 1 ) = SS.sigma;
   
    
    end
    
end


