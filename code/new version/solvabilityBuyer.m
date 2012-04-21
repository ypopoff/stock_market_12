%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ res ] = solvabilityBuyer( treg, ind, p, shares )
%solvabilityBuyer checks whether the buyer is solbable or not
%   returns a boolean value

   res = false;

   tliq = treg( ind, 1 );               %retrieve owned liquidities of the buyer
   inv = p * shares;                    %compute the liquidities the trader wants to invest
   
   if inv <= tliq
       
       res = true;
       
   end
   

end

