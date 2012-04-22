%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ res ] = solvencySeller( treg, ind, shares )
%solvencySeller checks the solvency of the seller
%   returns a boolean value -> true: solvency ok, otherwise false

   res = false;

   tshares = treg( ind, 2 );            %retrieve owned shares of the seller
   
   if shares <= tshares
       
       res = true;
       
   end
   

end

