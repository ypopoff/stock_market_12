%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

function [tprice, treg, sbp] = singleTransaction(sellerID, buyerID, sharesS, priceS, treg, tprice, sbp, EntryIndexS, EntryIndexB, i)
% Executes a single transaction between two parties
% Returns updated matrices tprice and treg

    amount = priceS * sharesS;                      % total cash to debit/credit
    
    % ToDo:  solvency!!!! -> if issues are present: delete entry (function?
    
    treg(buyerID,1) = treg(buyerID,1) - amount;     % update buyer's account
    treg(buyerID,2) = treg(buyerID,2) + sharesS;    % update buyer's share holdings
    
    treg(sellerID,1) = treg(sellerID,1) + amount;   % update seller's account
    treg(sellerID,2) = treg(sellerID,2) - sharesS;  % update seller's share holdings
    
    % New entry in tprice
    sbp = sbp + 1;                                  % increment number of entries in tprice
    
    tprice(sbp,:) = [priceS, sharesS, sellerID, EntryIndexS, buyerID, EntryIndexB, i];   

end
