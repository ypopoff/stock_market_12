%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ treg, p0, a, d, tliq, tsha, tnum ] = IPO( unitPrice, shares, tliq, tnum )
% simulates a very simple initial public offering of a firm
% inputs:  unitPrice for a share,  number of shares put on the market
% output:  treg trader matrix

	
	p0 = unitPrice;

	tsha = shares/tnum;		    % divides shares equally between all traders (shares must me a multiple of tnum !)

	a = p0;
	d = p0;

	one = ones(tnum,1);

	treg = [tliq*one, tsha*one];        %trader matrix (2 columns)





end