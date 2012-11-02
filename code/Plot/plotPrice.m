%©2012 ETH Z?rich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ SPL ] = plotPrice( i, SSM, SP, SPL, fig1 )
%PLOTPRICE Plots every deltat the price evolution

    set( 0, 'CurrentFigure', fig1 );
    
    %TODO Plot intervall
    deltat = 50;                                                            % plot every 50s


    if mod(i, deltat) == 0
        
        [ SPL.ymin, SPL.ymax ] = dynamicLimity( SSM.pmax, SSM.pmin, SPL.ymin, SPL.ymax );

        xmax = SP.M * SP.T;
        

        %% Get last transaction infos & plot in green
        if SSM.sbp ~= 0
            
            info = SSM.tprice( SSM.sbp, : );
            ent1 = info( 4 );
            ent1info = SSM.books( ent1, : );
            ent2 = info( 6 );
            ent2info = SSM.bookb( ent2, : );
            
            x = ent2info( 2 ); y = ent2info( 4 );
            subplot(2,2,1); plot( x, y, 'g*');
            line( [ x x ], [ SPL.ymin SPL.ymax ], 'Color', 'g' );
            
            x = ent1info( 2 ); y = ent1info( 4 );
            subplot(2,2,2); plot( x, y, 'g*' );
            line( [ x x ], [ SPL.ymin SPL.ymax ], 'Color', 'g' );
            
            x = info( 7 ); y = info( 1 );
            subplot(2,2,[3 4]); plot( x, y, 'g*' );
            line( [ x x ], [ SPL.ymin SPL.ymax ], 'Color', 'g' );
            
        end
        

        
        %% Buyer price subplot 
        subplot(2,2,1);
            hold on;
           
            Ap1 = [ 0; SSM.bookb(1:1:int32(SSM.sbb),2) ];
            Bp1 = [ SP.p0; SSM.bookb(1:1:int32(SSM.sbb),4) ];
            plot(Ap1, Bp1, 'b');
            
            hold off;
            
            xlim([0 xmax]);
            ylim([SPL.ymin SPL.ymax]);
            xlabel('time in seconds');
            ylabel('buyer entry price');
            title('Buyer price');

            
        %% Seller price subplot
        subplot(2,2,2);
            hold on;
            
            Ap2 = [ 0; SSM.books(1:1:int32(SSM.sbs),2) ];
            Bp2 = [ SP.p0; SSM.books(1:1:int32(SSM.sbs),4) ];
            plot(Ap2, Bp2, 'b');
            
            hold off;
            
            xlim([0 xmax]);
            ylim([SPL.ymin SPL.ymax]);
            xlabel('time in seconds');
            ylabel('seller entry price');
            title('Seller price');

        
        %% Transaction price subplot
        subplot(2,2,[3 4]);
            hold on;

            Ap3 = [ 0; SSM.avgtprice( 1:1:int32(SSM.savtp), 2 ) ];
            Bp3 = [ SP.p0; SSM.avgtprice( 1:1:int32(SSM.savtp), 1 ) ];
            plot( Ap3, Bp3, 'r' );
            
            hold off;
            
            xlim([0 xmax]);
            ylim([SPL.ymin SPL.ymax]);
            xlabel('time in seconds');
            ylabel('transaction price');
            title('Transaction price');
            
            
            
            %% Vertical day line

        for j = 1:1:SP.M
            
            subplot( 2, 2, 1 );
            line( [ j*SP.T j*SP.T ], [ SPL.ymin SPL.ymax ], 'Color', [0.75, 0.75, 0.75] );
            
            subplot( 2, 2, 2 );
            line( [ j*SP.T j*SP.T ], [ SPL.ymin SPL.ymax ], 'Color', [0.75, 0.75, 0.75] );
            
            subplot( 2, 2, [3 4] );
            line( [ j*SP.T j*SP.T ], [ SPL.ymin SPL.ymax ], 'Color', [0.75, 0.75, 0.75] );
            
        end
             
            
        drawnow;

        
    end


end