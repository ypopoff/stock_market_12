%�2012 ETH Z�rich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SSM, SP, SPL ] = init( )
%INIT Summary of this function goes here
%   Detailed explanation goes here


    %% Initialisation
    %   Contains all initial parameters
    %   Creates trader matrix & empty book matrixes

    bkempty = 1;                                                            % book emptying parameter
                                                                            % 0: Off, 1: On

    lambda = 20;                                                            % mean of the exponential distribution
    mu = 1;                                                                 % deviation
    sigma = 0.005;                                                          % mean of the gaussian (normal) distribution


    M = 10;                                                                 % number of days
    %M = 10;
    m = 0;                                                                  % starting at day 0
    h = 7;                                                                  % hours in one trading day
    %h = 2;
    T = 60*60*h;                                                            % number of seconds in one trading day
    t = 0;                                                                  % global time variable

    %% Trader & liquidities
    %   initial trader matrix (treg) is determined
    %   treg format: liquidities, shares -> row number is trader ID

    tnum = 100;                                                             % number of traders

    tliq = 10^5;                                                            % individual trader liquidity

    totShares = 1000*tnum;                                                  % total number of distributed shares

    p0 = 100;                                                               % starting unit price

    tshares = totShares/tnum;                                               % individual trader shares

    a = p0;                                                                 % asking price: seller
    d = p0;                                                                 % bid price: buyer

    one = ones(tnum,1);

    treg = [tliq*one, tshares*one, one * 0];                                % trader matrix (2 columns)

    for i = 1:1:tnum

        treg( i, 3 ) = 599 + randi(5401);                                   % determine time window

    end


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

    books = zeros(20000, 9);                                                % seller book
    sbs = 0;                                                                % actual amount of elements in books
    bookb = zeros(20000, 9);                                                % buyer book
    sbb = 0;                                                                % actual amount of elements in bookb


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

    bookspaging = zeros(2000, 5);                                           % seller book paging
    sbsp = 0;                                                               % actual #elements in bookspaging
    bookbpaging = zeros(2000, 5);                                           % buyer book paging
    sbbp = 0;                                                               % actual #elements in bookbpaging


    %% Transaction initialisation section
    %   - Transaction format:
    %   transaction price, amount of shares, seller id, index of entry in seller book,
    %   buyer id, index of entry in buyer book, transaction time 
    %   - Weighted Transaction format:
    %   weighted transaction price, transaction time

    tprice = zeros(1000, 7);                                                % transaction price matrix
    sbp = 0;                                                                % actual amount of elements in tprice

    avgtprice = zeros(1000, 2);                                             % weighted transaction price matrix
    savtp = 0;                                                              % actual number of elements in avgtprice


    %% Plot parameter section
    ymin = p0 - 25;
    ymax = p0 + 25;


    %% Log returns
    ret = zeros( 1000, 2 );
    retsize = 0;
    dt = 60;


    %% Debug
    debug = zeros( 1000, 4 );
    sd1 = 0; sd2 = 0; sd3 = 0; sd4 = 0;

    %% Maximum & minimum price ever occuring
    pmax = p0;
    pmin = p0;


    entrefresh = 0;
    volfeed = 0;
    entage = 1;
    mulshares = 1;

    korrbs = 1.0;
    korrk = 0.0004;
    a0 = 600;
    k = 1.5*1.12;

    tocc = zeros( 1000, 1 );
    st = 0;
    sige = zeros( 1000, 1 );
    se = 0;

    liveplot = 0;
    retymin = -5;
    retymax = 5;
    
    tregB4 = treg;                                                          % initial trader matrix used for comparison
    tnumB4 = tnum;
    
    %% Price Regulation
    
    regulate = 0;                                                           % toggle price regulation : 1 - on , 0 - off
    
    pC = 110;                                                               % price ceiling
    pF = 100;                                                               % price floor
    
    % allowing growth
    
    growth = 15;                                                            % constant allowed growth : % per day
    
    
    %% Financial bubble
    
    t1 = 1;                                                                 % growth start
    t2 = 7;                                                                 % crash
    t3 = 9;                                                                 % back to stability
    
    mu1 = 1.003;                                                            % increase
    mu2 = 0.980;                                                            % crash
    mu3 = 1;                                                                % stability
    
    devon = 0;
    
    
    %% Plot label caption!!!
    xfs = 14;
    yfs = 14;
    tfs = 16;
    
   
    
    %% Define and initialize current system state structure variable
    %   Group system parameters in a single structure for convenience and
    %   clarity
    global SSM;
    SSM = struct(   'treg',         treg,           ...
                    'bookbpaging',  bookbpaging,    ...
                    'sbbp',         sbbp,           ...
                    'bookspaging',  bookspaging,    ...
                    'sbsp',         sbsp,           ...
                    'bookb',        bookb,          ...
                    'sbb',          sbb,            ...
                    'books',        books,          ...
                    'sbs',          sbs,            ...
                    'a',            a,              ...
                    'd',            d,              ...
                    'sigma',        sigma,          ...
                    'tprice',       tprice,         ...
                    'sbp',          sbp,            ...
                    'ret',          ret,            ...
                    'retsize',      retsize,        ...
                    'avgtprice',    avgtprice,      ...
                    'savtp',        savtp,          ...
                    'sige',         sige,           ...
                    'se',           se,             ...
                    'tocc',         tocc,           ...
                    'st',           st,             ...
                    'debug',        debug,          ...
                    'sd1',          sd1,            ...
                    'sd2',          sd2,            ...
                    'sd3',          sd3,            ...
                    'sd4',          sd4,            ...
                    'pmax',         pmax,           ...
                    'pmin',         pmin            );



    %% System parameters
    %   Structure containing the parameters of the system
    global SP;
    SP = struct(    'tnum',         tnum,           ...
                    'totShares',    totShares,      ...
                    'bkempty',      bkempty,        ...
                    'mu',           mu,             ...
                    'lambda',       lambda,         ...
                    'p0',           p0,             ...
                    'T',            T,              ...
                    'M',            M,              ...
                    'dt',           dt,             ...
                    'korrbs',       korrbs,         ...
                    'korrk',        korrk,          ...
                    'a0',           a0,             ...
                    'k',            k,              ...
                    'entage',       entage,         ...
                    'entrefresh',   entrefresh,     ...
                    'mulshares',    mulshares,      ...
                    'volfeed',      volfeed,        ...
                    'regulate',     regulate,       ...
                    'pC',           pC,             ...
                    'pF',           pF,             ...
                    'growth',       growth,         ...
                    'devon',        devon,          ...
                    't1',           t1,             ...
                    't2',           t2,             ...
                    't3',           t3,             ...
                    'mu1',          mu1,            ...
                    'mu2',          mu2,            ...
                    'mu3',          mu3             );



    %% Plot parameters
    global SPL;
    SPL = struct(   'liveplot',     liveplot,       ...
                    'retymax',      retymax,        ...
                    'retymin',      retymin,        ...
                    'ymax',         ymax,           ...
                    'ymin',         ymin,           ...
                    'tregB4',       tregB4,         ...
                    'tnumB4',       tnumB4,         ...
                    'xfs',          xfs,            ...
                    'yfs',          yfs,            ...
                    'tfs',          tfs             );

end

