%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

%% Initial public offering (IPO)
%   simulates a very simple initial public offering of a firm
%   initial trader matrix (treg) is determined
%   treg format: liquidities, shares -> row number is trader ID
%   fortune format: time, companyWorth

tnum = 100;                         % number of traders

tliq = 10^5;                        % individual trader liquidity

totShares = 1000*tnum;              % total number of distributed shares

p0 = 100;                           % starting unit price

tshares = totShares/tnum;           % individual trader shares

a = p0;                             % asking price: seller
d = p0;                             % bid price: buyer

one = ones(tnum,1);

treg = [tliq*one, tshares*one];     % trader matrix (2 columns)

fortune = zeros(1000, 2);

fortune(1,2) = totShares * p0;      % initial fortune (time = 0)

fLen = 1;                           % number of entries in fortune matrix

