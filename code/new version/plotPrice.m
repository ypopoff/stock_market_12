function [] = plotPrice( i, SS )
%PLOTPRICE plots every ?t the price evolution
    
    deltat = 50;        %plot every 50s

    if mod(i, deltat) == 0

        xmax = SS.M * SS.T;

        %Plot section
        figure(1);
        
        
        %hold on;

        subplot(2,2,1);
            Ap = SS.bookb(1:1:SS.sbb,2);
            Bp = SS.bookb(1:1:SS.sbb,4);
            plot(Ap, Bp);
            xlim([0 xmax]);
            ylim([50 150]);
            xlabel('time in seconds');
            ylabel('buyer entry price');
            %drawnow;
        
        subplot(2,2,2);
            App = SS.books(1:1:SS.sbs,2);
            Bpp = SS.books(1:1:SS.sbs,4);
            plot(App, Bpp);
            xlim([0 xmax]);
            ylim([50 150]);
            xlabel('time in seconds');
            ylabel('seller entry price');
            %drawnow;
        
        
        subplot(2,2,[3 4]);
        plot(SS.tprice(1:1:SS.sbp, 7), SS.tprice(1:1:SS.sbp, 1), 'r');
        %xlim([0, max(tprice(1:1:end, 7))]);
        %ylim([min(tprice(1:1:end, 1)) - 1, max(tprice(1:1:end, 1)) + 1]);
        xlabel('time in seconds');
        ylabel('transaction price');
        %drawnow;

        %hold off;
        
    end
    
    SS.a = 0;



end

