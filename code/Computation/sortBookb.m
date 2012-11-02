%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SSM ] = sortBookb( SSM )
%SORTBOOKB sorts the paging book (buyer)
%   - The highest price is i the first row
%   - The sorting is in decreasing order
%   - If 2 or more entries have the same price, the oldest one comes first
%   (increasing order)

    A = SSM.bookbpaging( 1:1:SSM.sbbp, : );
    sortedpart = sortrows( A, [ -1 2 ] );                                   % 1. sort: decreasing for price
                                                                            % 2. sort: increasing for time
    SSM.bookbpaging( 1:1:SSM.sbbp, : ) = sortedpart;
    
    if SSM.sbbp ~= 0
        
        SSM.d = SSM.bookbpaging(1, 1);
        
    end

end

