%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ treg ] = transaction( treg, unitPrice, shares, sellerID, buyerID )
% carries the transaction out -> updates trader assets
% displays a warning if a trader is left with a negative account balance after the transaction
% returns the updated trader matrix treg



	amount = unitPrice * shares;		% total cash to debit/credit

	debitLiq = treg(buyerID, 1);		% account balance : buyerID trader


	if (debitLiq < amount)        		% trader doesn't have a high enough balance

		
		warning('negative account balance!!');


    end
    
    if (treg(sellerID,2) < shares)      % trader doesn't have enough shares
        
        warning('negative shares!!');
        
    end

	
	treg(buyerID, 1) = debitLiq - amount;		% update buyer's account

	treg(buyerID, 2) = treg(buyerID, 2) + shares;  	% update buyer's share holdings

	
	treg(sellerID, 1) = treg(sellerID, 1) + amount;	% update seller's account

	treg(sellerID, 2) = treg(sellerID, 2) - shares;	% update seller's share holdings



end