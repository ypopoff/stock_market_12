%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ymin, ymax ] = plotPrice( i, M, T, bookb, sbb, books, sbs, tprice, sbp, p0, a, d, ymin, ymax )
%PLOTPRICE plots every deltat the price evolution


    set(gcf,'doublebuffer','on') ; % remove flicker
    
    %TODO Plot intervall
    deltat = 50;        %plot every 50s


    if mod(i, deltat) == 0
        


        %TODO Define as global
        xmax = M * T;
        
        %[ ymin ymax ] = dynamicLimity( a, d, ymin, ymax );
        
        subplot( 2, 2, [3 4] );
        for j = 1:1:M
            
           line( [ j*T j*T ], [ ymin ymax ] );                              %draw vertical line for each day 
            
        end
        
        
        %hold on;
        
        %% Get last transaction infos & plot in green
        if sbp ~= 0
            
            info = tprice( sbp, : );
            ent1 = info( 4 );
            ent1info = books( ent1, : );
            ent2 = info( 6 );
            ent2info = bookb( ent2, : );
            
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
            
            Ap1 = bookb(1:1:sbb,2);
            Bp1 = bookb(1:1:sbb,4);
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
            
            Ap2 = books(1:1:sbs,2);
            Bp2 = books(1:1:sbs,4);
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

            Ap3 = [ 0; tprice( 1:1:sbp, 7 ) ];
            Bp3 = [ p0; tprice( 1:1:sbp, 1 ) ];
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

