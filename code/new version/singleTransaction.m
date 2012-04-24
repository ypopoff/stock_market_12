%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

function [ SS ] = singleTransaction(sellerID, buyerID, sharesS, priceS, SS, EntryIndexS, EntryIndexB, i)
% Executes a single transaction between two parties
% Returns updated matrices tprice and treg

    amount = priceS * sharesS;                      % total cash to debit/credit
    
    % ToDo:  solvency!!!! -> if issues are present: delete entry (function?
    
    SS.treg(buyerID,1) = SS.treg(buyerID,1) - amount;     % update buyer's account
    SS.treg(buyerID,2) = SS.treg(buyerID,2) + sharesS;    % update buyer's share holdings
    
    SS.treg(sellerID,1) = SS.treg(sellerID,1) + amount;   % update seller's account
    SS.treg(sellerID,2) = SS.treg(sellerID,2) - sharesS;  % update seller's share holdings
    
    % New entry in tprice
    SS.sbp = SS.sbp + 1;                                  % increment number of entries in tprice
    
    SS.tprice(SS.sbp,:) = [priceS, sharesS, sellerID, EntryIndexS, buyerID, EntryIndexB, i];   

end
