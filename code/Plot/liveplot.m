%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


set(gcf,'doublebuffer', 'on');                                              %remove flicker

scrsize = get( 0, 'ScreenSize' );                                           %get screen dimensions (main, secondary screen)
wd = scrsize( 3 );
hg = scrsize( 4 );

scrratio = hg / wd;                                                         %compute ratio; 4/3, 16/10, etc.

fig1wd = wd * 0.75;                                                         %fig1 75% of the screen
fig1hg = fig1wd * scrratio;

fig1 = figure( 1 );                                                         %select figure for plot
set( fig1, 'OuterPosition', [ 0, hg, fig1wd, fig1hg ] );                    %position & size of the figure