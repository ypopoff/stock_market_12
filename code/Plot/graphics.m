%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


%% Graphics setup section
%   Computes figure size depending on screen size

close all;                                                                  %close opened figures

set(gcf,'doublebuffer', 'on');                                              %remove flicker

scrsize = get( 0, 'ScreenSize' );                                           %get screen dimensions (main, secondary screen)
wd = scrsize( 3 );
hg = scrsize( 4 );

scrratio = hg / wd;                                                         %compute ratio; 4/3, 16/10, etc.

fig1wd = wd * 0.75;                                                         %fig1 75% of the screen
fig1hg = fig1wd * scrratio;

fig1 = figure( 1 );                                                         %select figure for plot
set( fig1, 'OuterPosition', [ 0, hg, fig1wd, fig1hg ] );                    %position & size of the figure

fig2wd = wd * 0.25;                                                         %fig2 25% of the screen
fig2hg = fig2wd * scrratio;

fig2 = figure( 2 );                                                         %position & size of the figure
set( fig2, 'OuterPosition', [ fig1wd, hg, fig2wd, fig2hg ] );

fig3wd = wd * 0.25;
fig3hg = fig3wd * scrratio;

fig3 = figure( 3 );
set( fig3, 'OuterPosition', [ 0.75/2 * wd, hg, fig3wd, fig3hg  ] );

fig4 = figure( 4 );
fig5 = figure( 5 );
fig6 = figure( 6 );
fig7 = figure( 7 );
fig8 = figure( 8 );