function [] = plotPrice( i, M, T, bookb, sbb, books, sbs, tprice, sbp )
%PLOTPRICE plots every ?t the price evolution
    
    deltat = 50;        %plot every 50s

    if mod(i, deltat) == 0

        xmax = M * T;

        %Plot section
        figure(1);
        
        
        %hold on;

        subplot(2,2,1);
            Ap = bookb(1:1:sbb,2);
            Bp = bookb(1:1:sbb,4);
            plot(Ap, Bp);
            xlim([0 xmax]);
            ylim([50 150]);
            xlabel('time in seconds');
            ylabel('buyer entry price');
            %drawnow;
        
        subplot(2,2,2);
            App = books(1:1:sbs,2);
            Bpp = books(1:1:sbs,4);
            plot(App, Bpp);
            xlim([0 xmax]);
            ylim([50 150]);
            xlabel('time in seconds');
            ylabel('seller entry price');
            %drawnow;
        
        
        subplot(2,2,[3 4]);
        plot(tprice(1:1:sbp, 7), tprice(1:1:sbp, 1), 'r');
        %xlim([0, max(tprice(1:1:end, 7))]);
        %ylim([min(tprice(1:1:end, 1)) - 1, max(tprice(1:1:end, 1)) + 1]);
        xlabel('time in seconds');
        ylabel('transaction price');
        %drawnow;

        %hold off;
        
    end
    
    a = 0;



end

