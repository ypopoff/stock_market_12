%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ res ] = solvencySeller( treg, ind, shares )
%solvencySeller checks whether the seller is solbable or not
%   returns a boolean value

   res = false;

   tshares = treg( ind, 2 );            %retrieve owned shares of the seller
   
   if shares <= tshares
       
       res = true;
       
   end
   

end

