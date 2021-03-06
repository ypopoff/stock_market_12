%�2012 ETH Z?rich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ymin, ymax ] = plotPrice( i, SS, ymin, ymax, fig1 )
%PLOTPRICE plots every deltat the price evolution

    set( 0, 'CurrentFigure', fig1 );
    
    %TODO Plot intervall
    deltat = 50;        %plot every 50s


    if mod(i, deltat) == 0
        
        [ ymin, ymax ] = dynamicLimity( SS.a, SS.d, ymin, ymax );

        xmax = SS.M * SS.T;
        

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
            hold on;
           
            Ap1 = [ 0; SS.bookb(1:1:int32(SS.sbb),2) ];
            Bp1 = [ SS.p0; SS.bookb(1:1:int32(SS.sbb),4) ];
            plot(Ap1, Bp1, 'b');
            
            hold off;
            
            xlim([0 xmax]);
            ylim([ymin ymax]);
            xlabel('time in seconds');
            ylabel('buyer entry price');
            title('Buyer price');

            
        %% Seller price subplot
        subplot(2,2,2);
            hold on;
            
            Ap2 = [ 0; SS.books(1:1:int32(SS.sbs),2) ];
            Bp2 = [ SS.p0; SS.books(1:1:int32(SS.sbs),4) ];
            plot(Ap2, Bp2, 'b');
            
            hold off;
            
            xlim([0 xmax]);
            ylim([ymin ymax]);
            xlabel('time in seconds');
            ylabel('seller entry price');
            title('Seller price');

        
        %% Transaction price subplot
        subplot(2,2,[3 4]);
            hold on;

            Ap3 = [ 0; SS.avgtprice( 1:1:int32(SS.savtp), 2 ) ];
            Bp3 = [ SS.p0; SS.avgtprice( 1:1:int32(SS.savtp), 1 ) ];
            plot( Ap3, Bp3, 'r' );
            
            hold off;
            
            xlim([0 xmax]);
            ylim([ymin ymax]);
            xlabel('time in seconds');
            ylabel('transaction price');
            title('Transaction price');
            
            
            
            %% Vertical day line

        for j = 1:1:SS.M
            
            subplot( 2, 2, 1 );
            line( [ j*SS.T j*SS.T ], [ ymin ymax ], 'Color', [0.75, 0.75, 0.75] );
            
            subplot( 2, 2, 2 );
            line( [ j*SS.T j*SS.T ], [ ymin ymax ], 'Color', [0.75, 0.75, 0.75] );
            
            subplot( 2, 2, [3 4] );
            line( [ j*SS.T j*SS.T ], [ ymin ymax ], 'Color', [0.75, 0.75, 0.75] );
            
        end
             
            
        drawnow;

        
    end


end