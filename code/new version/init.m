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


%% IPO section
%   - treg is the trader matrix
%   - Format: liquidities, shares
%   - The index of the row is the index of the trader

p0 = 100;                           %starting price
[ treg, p0, a, d, tliq, tsha, tnum ] = IPO( p0, shares, tliq, tnum );
                                    % initial public offering


%% Books initialisation section (seller & buyer book)
%   - Book format:
%   day, time, seller/buyer id, s/b price, dirty bit, age bit, new entry
%   bit
%   - For practical purposes, the book entries are never erased
%   - A dirty bit is added to each entry, to inform whether the entry
%   is active or not
%   - The number of the entry is the index of the matrix row)
%   - The age bit is 1 if the entry was made inactive due to its age
%   - The new entry bit is 1 if the auction was added by a trader who wants
%   to refresh his auction

books = zeros(1000, 7);             %seller book
sbs = 0;                            %actual amount of elements in books
bookb = zeros(1000, 7);             %buyer book
sbb = 0;                            %actual amount of elements in bookb


%% Book paging section
%   - The paging of the book is used to sort the still valid book entries
%   without changing the actual book order (sorted chronologically)
%   - The paging book is sorted after the price
%   i.e. 1. row : lowest price,        amount of shares,   index of entry
%        in book
%        2. row : second lowest price, amount of shares,   index of entry
%        in book
%        3 ...
%   - When transaction is done: the amount of shares is decreased, or the
%   whole entry is ereased if amount of shares == 0

bookspaging = zeros(1000, 3);       %seller book paging
sbsp = 0;                           %actual #elements in bookspaging
bookbpaging = zeros(1000, 3);       %buyer book paging
sbbp = 0;                           %actual #elements in bookbpaging


%% Transaction initialisation section
%   - Transaction format:
%   transaction price, time the corresponding auction was entered (in the past),
%   actual transaction time

tprice = zeros(1000, 3);            %transaction price matrix
sbp = 0;                            %actual amount of elements in tprice

