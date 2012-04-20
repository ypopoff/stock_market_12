%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

%% Initialisation
%   Contains all initial parameters
%   Creates trader matrix & empty book matrixes

bkempty = 1;                        %book emptying parameter
                                    %0: Off, 1: On


tnum = 100;                         %number of traders
tliq = 10^5;                        %liquidity
shares = (10^3)*tnum;               %shares

lambda = 20;                        %mean of the exponential distribution
mu = 1;                             %deviation
sigma = 0.005;                      %mean of the gaussian (normal) distribution


M = 10;                             %number of days
m = 0;                              %starting at day 0
T = 60*60*7;                        %number of seconds in one trading day
t = 0;                              %global time variable


p0 = 100;                           %starting price
[ treg, p0, a, d, tliq, tsha, tnum ] = IPO( p0, shares, tliq, tnum );
                                    % initial public offering


%% Books initialisation section (seller & buyer book)
%   Book format:
%   day, time, seller/buyer id, s/b price, dirty bit


%Major Update: for practical purposes, the book entries are never erased
%   A dirty bit is added to each entry, to inform whether the entry
%   is active or not
%   (the number of the entry is the index of the matrix row)

books = zeros(1000, 4);             %seller book
sbs = 0;                            %actual amount of elements in books
bookb = zeros(1000, 4);             %buyer book
sbb = 0;                            %actual amount of elements in bookb


%% Transaction initialisation section
%   Transaction format:
%   transaction price, time the corresponding auction was entered (in the past),
%   actual transaction time

tprice = zeros(1000, 3);            %transaction price matrix
sbp = 0;                            %actual amount of elements in tprice

