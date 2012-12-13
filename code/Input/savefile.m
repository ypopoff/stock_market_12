%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ] = savefile( SSM, SP, SPL, path, simfold, sparam, sinfo, ctrl )
%SAVEFILE Save input file


    cd( '../' );
    
    %% Actual simulation folder
    simufolder = sprintf( '%s/%s', path, simfold );
    simufolder = regexprep( simufolder, '**', num2str(ctrl) );
    mkdir( simufolder );

    
    %% Create parameters file
    filename = sprintf( '%s/%s', simufolder, sparam );
    filename = regexprep( filename, '**', num2str(ctrl) );
    save( filename, 'SSM', 'SP', 'SPL' );

    
    %% Create info file
    infofilename = sprintf( '%s/%s', simufolder, sinfo );
    infofilename = regexprep( infofilename, '**', num2str(ctrl) );
    file = fopen( infofilename, 'w' );

    
        %% Overhead
        dstr = date;
        cstr = clock;
        fprintf(file, '©2012 ETH Zuerich\nBambolei\nNicholas Eyring, Youri Popoff\nSimulation of trading in an artificial stock market\n\n\n\n');
        fprintf(file, '                                     **** SIMULATION %u ****\n\n', ctrl);
        fprintf(file, '                                            Information file\n\n');

        fprintf(file, '                                                    Date:  %s\n',     dstr);
        fprintf(file, '                                                    Time:  %02.0f:%02.0f:%02.0f\n\n', cstr(4), cstr(5), cstr(6));

        
        %% Parameters
        fprintf(file, ' - SIMULATION MODUS -                                        \n');
        fprintf(file, '                    Empty book (On/Off) -        bkempty:  %u\n',     SP.bkempty);
        fprintf(file, '                 Entry refresh (On/Off) -     entrefresh:  %u\n',     SP.entrefresh);
        fprintf(file, '       Entry erasure when aged (On/Off) -         entage:  %u\n',     SP.entage);
        fprintf(file, '               Multiple shares (On/Off) -      mulshares:  %u\n',     SP.mulshares);
        fprintf(file, '           Volatility feedback (On/Off) -        volfeed:  %u\n',     SP.volfeed);
        fprintf(file, '              Price regulation (On/Off) -       regulate:  %u\n',     SP.regulate);
        fprintf(file, '              Financial bubble (On/Off) -          devon:  %u\n\n\n', SP.devon);
        
        fprintf(file, ' - STANDARD PARAMETERS (used in all of the modi)             \n');
        fprintf(file, '                      Number of traders -           tnum:  %u\n',     SP.tnum);
        fprintf(file, '                       Amount of shares -      totShares:  %u\n',     SP.totShares);
        fprintf(file, '                         Starting price -             p0:  %.2f\n\n', SP.p0);

        fprintf(file, '            Mean of normal distribution -             mu:  %.4f\n',   SP.mu);
        fprintf(file, ' Initial std. deviation of normal dist. -          sigma:  %.4f\n',   SSM.sigma);
        fprintf(file, '  Parameter of exponential distribution -         lambda:  %.4f\n\n', SP.lambda);

        fprintf(file, '                             Total days -              M:  %u\n',     SP.M);
        fprintf(file, '                  Total time in seconds -              T:  %u\n\n',   SP.T);

        fprintf(file, '             Last tick iteration window -             dt:  %.2f\n\n\n', SP.dt);

        fprintf(file, ' - VOLATILITY FEEDBACK PARAMETERS -                          \n');
        fprintf(file, '                  Sigma constant factor -              k:  %.2f\n',   SP.k);
        fprintf(file, '             Buyer - Seller correlation -         korrbs:  %.2f\n',   SP.korrbs);
        fprintf(file, '            Old - New sigma correlation -          korrk:  %.6f\n',   SP.korrk);
        fprintf(file, '                   Maximum age of entry -             a0:  %.2f\n\n\n', SP.a0);
        
        fprintf(file, ' - PRICE REGULATION PARAMETERS -                             \n');
        fprintf(file, '                                 Growth -         growth:  %.2f\n',   SP.growth);
        fprintf(file, '                            Price floor -             pF:  %.2f\n',   SP.pF);
        fprintf(file, '                          Price ceiling -             pC:  %.2f\n\n\n', SP.pC);
        
        fprintf(file, ' - FINANCIAL BUBBLE PARAMETERS -                             \n');
        fprintf(file, '          Stability mean of norm. dist. -            mu3:  %.2f\n',   SP.mu3);
        fprintf(file, '                    Bubble starting day -             t1:  %u\n',     SP.t1);
        fprintf(file, '           Increase mean of norm. dist. -            mu1:  %.2f\n',   SP.mu1);
        fprintf(file, '                    Day of bubble burst -             t2:  %u\n',     SP.t2);
        fprintf(file, '           Decrease mean of norm. dist. -            mu2:  %.2f\n',   SP.mu2);
        fprintf(file, '           Day of stability after burst -             t3:  %u\n\n\n', SP.t3);


        fclose(file);
        
        
        cd( 'Input/' );
        

end

