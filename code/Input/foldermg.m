%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ simpath, simnum, amount ] = foldermg( mainfolder, simulationfolder, simulationinfo, comp, simfold, sparam, sinfo, newfolder, parfold, spr, stru )
%FOLDERMG Creates simulation file structure
%   Returns actual simualtion folder and amount of sim to execute


    cd('../');                                                              % change to main folder

    
    %% Remove old folder if existing
    if ( exist(mainfolder,'dir') == 7 )

        warning('Folder already existing');
        
        if newfolder == 1
            
            rmdir(mainfolder,'s');
                    
        end

    else

        mkdir(mainfolder);

    end


    %% Simulation folder
    i = 0;
    prefix = sprintf('%s/%s', mainfolder, simulationfolder);
    tprefix = regexprep(prefix, '**', num2str(i)); 

    while ( exist(tprefix, 'dir') == 7 )

        i = i + 1;
        tprefix = regexprep(prefix, '**', num2str(i)); 

    end
    
    mkdir(tprefix);
    simpath = tprefix;
    simnum = i;
    
    
    %% Create compare folder
    cf = sprintf( '%s/%s', tprefix, comp );
    mkdir(cf);


    %% Simulation file
    
    cd( 'Input/' );
    
        [SSM, SP, SPL] = init();                                            % call standard parameters   
        [ amount ] = paramSweepCall( SSM, SP, SPL, simpath, simfold, sparam, sinfo, parfold, spr, stru );
    
    cd( '../' );
    
    %% Create info file
    infofilename = sprintf('%s/%s', mainfolder, simulationinfo);
    infofilename = regexprep(infofilename, '**', num2str(i)); 
    simfile = fopen(infofilename, 'w');

        % overhead
        dstr = date;
        cstr = clock;
        fprintf(simfile, '©2012 ETH Zuerich\nBambolei\nNicholas Eyring, Youri Popoff\nSimulation of trading in an artificial stock market\n\n\n\n');
        fprintf(simfile, '                                     **** Global SIMULATION %u ****\n\n', simnum);
        fprintf(simfile, '                                            Info file\n\n');

        fprintf(simfile, '                                                    Date:  %s\n',            dstr);
        fprintf(simfile, '                                                    Time:  %02.0f:%02.0f:%02.0f\n\n', cstr(4), cstr(5), cstr(6));

        fprintf(simfile, '                                   Number of simulations:  %u\n',            amount);
        fprintf(simfile, '                                         Simulation info:  %s/%s/%s\n',      tprefix, simfold, sinfo);
        fprintf(simfile, '                                   Simulation parameters:  %s/%s/%s\n\n',    tprefix, simfold, sparam);

        fclose(simfile);

    
    cd( 'Input/' );                                                         % go back to function folder


end

