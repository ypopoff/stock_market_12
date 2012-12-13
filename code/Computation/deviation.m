%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market



function [ SP, m ] = deviation( SP, m )
%DEVIATION changes the standard deviation of the price

    if SP.devon == 1

        if m > SP.t1 && m < SP.t2

            SP.mu = SP.mu1;

        elseif m > SP.t2 && m < SP.t3

            SP.mu = SP.mu2;

        else

            SP.mu = SP.mu3;

        end
        
    end


end

