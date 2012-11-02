%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SSM ] = sortBooks( SSM )
%SORTBOOKS sorts the paging book (seller)
%   - The lowest price is i the first row
%   - The sorting is in increasing order
%   - If 2 or more entries have the same price, the oldest one comes first
%   (increasing order)

    A = SSM.bookspaging( 1:1:SSM.sbsp, : );
    sortedpart = sortrows( A, [ 1 2 ] );                                    % 1. sort: increasing for price
                                                                            % 2. sort: increasing for time
    SSM.bookspaging( 1:1:SSM.sbsp, : ) = sortedpart;
    
    if SSM.sbsp ~= 0
        
        SSM.a = SSM.bookspaging(1, 1);
        
    end

end
