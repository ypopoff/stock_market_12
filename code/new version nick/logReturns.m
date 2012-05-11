%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


% function [ SS ] = logReturns( SS )
% %LOGRETURNS computes log returns each dt = 60s
% %   returns logreturns in the SS.ret matrix
% 
% 
% %Matrix format:
% %       Column 1            Column 2        (Time intervall)
% % 1     price p. tick       log-ret         1   -  60s
% % 2     price p. tick       log-ret         61  - 120s
% % 3     price p. tick       log-ret         121 - 180s
% % ...
% 
%      
%     %tindex = SS.savtp;                     % use weighted transaction price
%     tindex = SS.sbp; 
%     
%     SS.retsize = SS.retsize + 1;           % increment retsize
%     
%    
%     %% Find last tick (previous-tick interpolation)
%      
%     if tindex > 0                            % we have transaction values !
%     
%         SS.ret(SS.retsize,1) = SS.tprice( tindex, 1 );  % write tick price into matrix
% 
% 
%         %% Compute log-return
%         % in percent
%     
%         if SS.retsize > 1
% 
%             SS.ret( SS.retsize, 2 ) = 100 * log( SS.ret(SS.retsize,1) / SS.ret(SS.retsize - 1,1) ); 
%        
%         else
%             
%             SS.ret( SS.retsize,2) = 0;                  % set return to zero if we don't have enough entries!
%         
%         end
% 
%     
%     else
%         
%         SS.ret(SS.retsize,1) = SS.p0;                    % use initial price if no transactions have occured (previous tick ?)
%         SS.ret(SS.retsize,2) = 0;                        % set return to zero (nothing has changed yet!)
% 
%     end
%   
%   
% 
% end



