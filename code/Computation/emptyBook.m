%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market



function [ SSM ] = emptyBook( SSM, SP )
%EMPTYBOOK empties book if needed


    if SP.bkempty == 1

        SSM.bookbpaging(1:1:SSM.sbbp, :) = [];                              % book emptying
        SSM.sbbp = 0;
        SSM.bookspaging(1:1:SSM.sbsp, :) = [];
        SSM.sbsp = 0;
        
        SSM.bookb( 1:1:SSM.sbb, 6 ) = zeros( SSM.sbb, 1 );                  % valid bit to zero
        SSM.books( 1:1:SSM.sbs, 6 ) = zeros( SSM.sbs, 1 );
            
    end


end

