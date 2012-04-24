%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market



function [ SS ] = emptyBook( SS )
%emptyBook empties book if needed


    if SS.bkempty == 1

        SS.bookb(1:1:SS.sbb, :) = [];              %book emptying
        SS.sbb = 0;
        SS.books(1:1:SS.sbs, :) = [];
        SS.sbs = 0;
            
    end



end

