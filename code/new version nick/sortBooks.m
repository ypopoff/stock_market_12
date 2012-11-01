%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SS ] = sortBooks( SS )
%sortBookb sorts the paging book (seller)
%   - The lowest price is i the first row
%   - The sorting is in increasing order
%   - If 2 or more entries have the same price, the oldest one comes first
%   (increasing order)

    A = SS.bookspaging( 1:1:SS.sbsp, : );
    sortedpart = sortrows( A, [ 1 2 ] );    %1. sort: increasing for price
                                            %2. sort: increasing for time
    SS.bookspaging( 1:1:SS.sbsp, : ) = sortedpart;
    
    if SS.sbsp ~= 0
        
        SS.a = SS.bookspaging(1, 1);
        
    end

end
