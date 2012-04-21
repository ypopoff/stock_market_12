%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ res ] = sortBooks( bookspaging, sbsp )
%sortBookb sorts the paging book (seller)
%   -The lowest price is i the first row
%   -The sorting is in increasing order
%   -If 2 or more entries have the same price, the oldest one comes first
%   (increasing order)

    A = bookspaging( [ 1:1:sbsp ], : );
    res = sortrows( A, [ 1 2 ] );           %1. sort: increasing for price
                                            %2. sort: increasing for time

end
