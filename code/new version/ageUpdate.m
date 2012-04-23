%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ bookpaging ] = ageUpdate( bookpaging, sb )
%ageUpdate updates age of auction

    if sb > 0

        bookpaging( 1:1:sb, 5 ) = bookpaging( 1:1:sb, 5 ) - ones( sb, 1 );                  %maximal age column minus 1 in paging matrix
        
    end

end

