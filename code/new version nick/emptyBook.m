%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market



function [ SS ] = emptyBook( SS )
%emptyBook empties book if needed


    if SS.bkempty == 1

        SS.bookbpaging(1:1:SS.sbbp, :) = [];              %book emptying
        SS.sbbp = 0;
        SS.bookspaging(1:1:SS.sbsp, :) = [];
        SS.sbsp = 0;
        
        SS.bookb( 1:1:SS.sbb, 6 ) = zeros( SS.sbb, 1 );
        SS.books( 1:1:SS.sbs, 6 ) = zeros( SS.sbs, 1 );
            
    end



end

