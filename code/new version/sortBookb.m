%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ res ] = sortBookb( bookbpaging, sbbp )
%sortBookb sorts the paging book (buyer)
%   -The highest price is i the first row
%   -The sorting is in decreasing order
%   -If 2 or more entries have the same price, the oldest one comes first
%   (increasing order)

    A = bookbpaging( [ 1:1:sbbp ], : );
    res = sortrows( A, [ -1 2 ] );          %1. sort: decreasing for price
                                            %2. sort: increasing for time

end

