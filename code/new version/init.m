%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market

%% Initialisation
%   Contains all initial parameters
%   Creates trader matrix & empty book matrixes

bkempty = 0;                        %book emptying parameter
                                    %0: Off, 1: On

lambda = 20;                        %mean of the exponential distribution
mu = 1;                             %deviation
sigma = 0.005;                      %mean of the gaussian (normal) distribution


M = 1;                              %number of days
m = 0;                              %starting at day 0
T = 60*60*7;                        %number of seconds in one trading day
t = 0;                              %global time variable


%% IPO section

IPO                                 % initial public offering (script)


%% Books initialisation section (seller & buyer book)
%   - Book format:
%   day, time, seller/buyer id, s/b price, shares, dirty bit, age bit, new
%   entry number, index of aged entry
%   
%   - For practical purposes, the book entries are never erased
%   - A dirty bit is added to each entry, to inform whether the entry
%   is active or not
%   - The number of the entry is the index of the matrix row)
%   - The age bit is 1 if the entry was made inactive due to its age
%   - The new entry bit is 1 if the auction was added by a trader who wants
%   to refresh his auction

books = zeros(20000, 9);            %seller book
sbs = 0;                            %actual amount of elements in books
bookb = zeros(20000, 9);            %buyer book
sbb = 0;                            %actual amount of elements in bookb


%% Book paging section
%   - The paging of the book is used to sort the still valid book entries
%   without changing the actual book order (sorted chronologically)
%   - The paging book is sorted after the price
%   i.e. 1. row : lowest price,        time,    amount of shares,   index of entry
%        in book, lifespan
%        2. row : second lowest price, time,    amount of shares,   index of entry
%        in book, lifespan
%        3 ...
%   - When transaction is done: the amount of shares is decreased, or the
%   whole entry is ereased if amount of shares == 0

bookspaging = zeros(2000, 5);       %seller book paging
sbsp = 0;                           %actual #elements in bookspaging
bookbpaging = zeros(2000, 5);       %buyer book paging
sbbp = 0;                           %actual #elements in bookbpaging


%% Transaction initialisation section
%   - Transaction format:
%   transction price, amount of shares, seller id, index of entry in seller book,
%   buyer id, index of entry in buyer book, transaction time 

tprice = zeros(1000, 7);            %transaction price matrix
sbp = 0;                            %actual amount of elements in tprice

