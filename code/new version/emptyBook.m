%�2012 ETH Z�rich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ bookb, sbb, books, sbs ] = emptyBook( bookb, sbb, books, sbs )
%emptyBook empties book if needed


    bookb(1:1:sbb, :) = [];                                             %book emptying
    sbb = 0;
    books(1:1:sbs, :) = [];
    sbs = 0;


end

