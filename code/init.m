%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


%Initialisation
%   Contains all initial parameters
%   Creates trader matrix & empty book matrixes


tnum = 100;                         %number of traders
tliq = 10^5;                        %liquidity
tsha = 10^3;                        %shares

lambda = 20;                        %mean of the exponential distribution
mu = 1;                             %deviation
sigma = 0.005;                      %mean of the gaussian (normal) distribution


M = 10;                             %number of days
m = 0;                              %starting at day 0
T = 60*60*7;                        %number of seconds in one trading day
t = 0;                              %global time variable

p0 = 100;                           %starting price
a = p0;                             %asking price: seller
d = p0;                             %bid price: buyer

one = ones(tnum,1);

treg = [tliq*one, tsha*one];        %trader matrix (2 columns)

books = zeros(1000, 5);             %seller book
sbs = 0;                            %actual amount of elements in books
bookb = zeros(1000, 5);             %buyer book
sbb = 0;                            %actual amount of elements in bookb

tprice = zeros(1000, 3);            %transaction price matrix

sbp = 0;                            %actual amount of elements in tprice

