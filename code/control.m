%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


clear all; clf; close all; clc;


%% Get path information
pathfile = fopen('path.txt','r');

frewind(pathfile);

mf = fscanf(pathfile, '%s', 1 );                                            % main folder
sf = fscanf(pathfile, '%s', 1 );                                            % simulation folder
gsin = fscanf(pathfile, '%s', 1 );                                          % global simulation info file
comp = fscanf(pathfile, '%s', 1 );                                          % compare folder name
simf = fscanf(pathfile, '%s', 1 );                                          % sim folder name
spa = fscanf(pathfile, '%s', 1 );                                           % sim parameter file
sin = fscanf(pathfile, '%s', 1 );                                           % sim info file
srep = fscanf(pathfile, '%s', 1 );                                          % sim report file
gsrep = fscanf(pathfile, '%s', 1 );                                         % global simulation report
plt = fscanf(pathfile, '%s', 1 );                                           % sim plot files (more than one)
parfold = fscanf(pathfile, '%s', 1 );                                       % parameter sweep instruction folder
spr = fscanf(pathfile, '%s', 1 );                                           % parameter sweep file
stru = fscanf(pathfile, '%s', 1 );                                          % tree structure file


fclose(pathfile);

newfolder = 0;                                                              % create new folder


%% Create input
cd('Input');
    [simpath, simnum, amount] = foldermg( mf, sf, gsin, comp, simf, spa, sin, newfolder, parfold, spr, stru );
cd('../');


%% Load input & simulate
startdate = date;
starttime = clock;
ticID2 = tic;

i = 0;
%digit = floor(log10(amount-1))+1;                                           % amount of digits needed for numerotation
%simustr = sprintf('%0*.0f', digit, i);
paramfile = sprintf( '%s/%s/%s', simpath, simf, spa );
tparamfile = regexprep( paramfile, '**', num2str(i) );

fs = 0;
failsim = zeros( 1, 1000 );
while ( exist(tparamfile, 'file' ) ~= 0 )
    
    
    try                                                                     % in case of error, the global simulation
                                                                            % continues but the subsimulation stops
                                                                            % and the error is reported
        ticID1 = tic;                                                       % start timer
        
        %% Start simulation
        load( tparamfile );

        cd( 'Computation/' );
        
            [ SSM, SP, SPL ] = main( SSM, SP, SPL );
            
        cd( '../' );
        
        
        %% Plot section
        cd( 'Plot/' );
    
            plotpath = sprintf( '%s/%s/%s', simpath, simf, plt );
            plotpath = regexprep( plotpath, '**', num2str(i) );
            plotpath = regexprep( plotpath, 'plot', '' );

            comparepath = sprintf( '%s/%s/%s', simpath, comp, plt );
            comparepath = regexprep( comparepath, '**', num2str(i) );
            comparepath = regexprep( comparepath, 'plot', '' );

            plotCall( SSM, SP, SPL, plotpath, comparepath );
    
        cd( '../' );

        
        rstat = 'Simulation was succesful!';
        errmsg = '-';
        
    catch ME

        fs = fs + 1;
        failsim( fs, : ) = i;
        rstat = 'Simulation failed!';
        errmsg = ME.message;
        
        cd( '../' );

    end

    
    ctime = toc(ticID1);
    
    %% Create report file
    reportfilename = sprintf( '%s/%s/%s', simpath, simf, srep );
    reportfilename = regexprep( reportfilename, '**', num2str(i) );
    file = fopen( reportfilename, 'w' );

    % overhead
    dstr = date;
    cstr = clock;
    fprintf(file, '©2012 ETH Zuerich\nBambolei\nNicholas Eyring, Youri Popoff\nSimulation of trading in an artificial stock market\n\n\n\n');
    fprintf(file, '                                     **** SIMULATION %u ****\n\n', i);
    fprintf(file, '                                            Report file\n\n');

    fprintf(file, '                                                    Date:  %s\n',    dstr);
    fprintf(file, '                                                    Time:  %02.0f:%02.0f:%02.0f\n\n', cstr(4), cstr(5), cstr(6));

    % text
    fprintf(file, '                   Computation duration -          ctime:  %f\n',    ctime);
    fprintf(file, '                          Report status -          rstat:  %s\n',    rstat);
    fprintf(file, '                          Error message -         errmsg:  %s\n\n',  errmsg);
    
    fclose(file);
    

    i = i + 1;
    tparamfile = regexprep( paramfile, '**', num2str(i) );
    
    
end

enddate = date;
endtime = clock;

dur = toc(ticID2);

%% Global simulation report
grepfilename = sprintf('%s/%s', mf, gsrep);
grepfilename = regexprep(grepfilename, '**', num2str(simnum));
rep = fopen(grepfilename, 'w');

% overhead
dstr = date;
cstr = clock;
fprintf(rep, '©2012 ETH Zuerich\nBambolei\nNicholas Eyring, Youri Popoff\nSimulation of trading in an artificial stock market\n\n\n\n');
fprintf(rep, '                                     **** Global SIMULATION %u ****\n\n', simnum);
fprintf(rep, '                                            Report file\n\n');

fprintf(rep, '                                                    Date:  %s\n',     dstr);
fprintf(rep, '                                                    Time:  %02.0f:%02.0f:%02.0f\n\n', cstr(4), cstr(5), cstr(6));

% text
fprintf(rep, '           Amount of failed simulations -             fs:  %u\n\n',   fs);

fprintf(rep, '                          Starting date -      startdate:  %s\n',     startdate);
fprintf(rep, '                           Sarting time -      starttime:  %02.0f:%02.0f:%02.0f\n\n', starttime(4), starttime(5), starttime(6));

fprintf(rep, '                            Ending date -        enddate:  %s\n',     enddate);
fprintf(rep, '                            Ending time -        endtime:  %02.0f:%02.0f:%02.0f\n\n', endtime(4), endtime(5), endtime(6));

fprintf(rep, '                               Duration -            dur:  %f\n\n\n', dur);

% Failed simulation index list
if fs > 0

fprintf(rep, '                                            Index of failed simulations\n\n');
    
end

for n = 1:1:fs
    
fprintf(rep, '                                        - %u\n', failsim(n));


end


    
fclose(rep);


    