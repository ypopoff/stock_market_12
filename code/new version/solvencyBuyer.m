%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ res ] = solvencyBuyer( treg, ind, p, shares )
%solvencyBuyer checks the solvency of the buyer
%   returns a boolean value -> true: solvency ok, otherwise false

   res = false;

   tliq = treg( ind, 1 );               %retrieve owned liquidities of the buyer
   inv = p * shares;                    %compute the liquidities the trader wants to invest
   
   if inv <= tliq
       
       res = true;
       
   end
   

end

