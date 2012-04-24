%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ymin, ymax ] = plotPrice( i, SS, ymin, ymax )
%PLOTPRICE plots every ?t the price evolution
    
    %TODO Plot intervall
    deltat = 50;        %plot every 50s


    if mod(i, deltat) == 0
        


        xmax = SS.M * SS.T;

        
        %[ ymin ymax ] = dynamicLimity( a, d, ymin, ymax );
        
        subplot( 2, 2, [3 4] );
        for j = 1:1:SS.M
            
           line( [ j*SS.T j*SS.T ], [ ymin ymax ] );                              %draw vertical line for each day 
            
        end
        
        
        %hold on;
        
        %% Get last transaction infos & plot in green
        if SS.sbp ~= 0
            
            info = SS.tprice( SS.sbp, : );
            ent1 = info( 4 );
            ent1info = SS.books( ent1, : );
            ent2 = info( 6 );
            ent2info = SS.bookb( ent2, : );
            
            x = ent2info( 2 ); y = ent2info( 4 );
            subplot(2,2,1); plot( x, y, 'g*');
            line( [ x x ], [ ymin ymax ], 'Color', 'g' );
            
            x = ent1info( 2 ); y = ent1info( 4 );
            subplot(2,2,2); plot( x, y, 'g*' );
            line( [ x x ], [ ymin ymax ], 'Color', 'g' );
            
            x = info( 7 ); y = info( 1 );
            subplot(2,2,[3 4]); plot( x, y, 'g*' );
            line( [ x x ], [ ymin ymax ], 'Color', 'g' );
            
        end
        
        
        
        %% Buyer price subplot 
        subplot(2,2,1);

            Ap = SS.bookb(1:1:SS.sbb,2);
            Bp = SS.bookb(1:1:SS.sbb,4);
            plot(Ap, Bp);
            xlim([0 xmax]);
            ylim([ymin ymax]);
            xlabel('time in seconds');
            ylabel('buyer entry price');
            title('Buyer price');

            
        %% Seller price subplot
        subplot(2,2,2);

            App = SS.books(1:1:SS.sbs,2);
            Bpp = SS.books(1:1:SS.sbs,4);
            plot(App, Bpp);
            xlim([0 xmax]);
            ylim([ymin ymax]);
            xlabel('time in seconds');
            ylabel('seller entry price');
            title('Seller price');

        
        %% Transaction price subplot
        subplot(2,2,[3 4]);

            hold on;

            Ap3 = [ 0; SS.tprice( 1:1:SS.sbp, 7 ) ];
            Bp3 = [ SS.p0; SS.tprice( 1:1:SS.sbp, 1 ) ];
            plot( Ap3, Bp3, 'r' );
            
            hold off;
            
            xlim([0 xmax]);
            ylim([ymin ymax]);
            xlabel('time in seconds');
            ylabel('transaction price');
            title('Transaction price');
            
            
        drawnow;


        
    end


end

