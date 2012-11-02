%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


%% Get path information
cd('../');                                                                  % change to main folder
pathfile = fopen('path.txt','r');

frewind(pathfile);
mainfolder = fscanf(pathfile, '%s', 1 );
simulationfolder = fscanf(pathfile, '%s', 1 );
simulationinfo = fscanf(pathfile, '%s', 1 );
sparam = fscanf(pathfile, '%s', 1 );
sinfo = fscanf(pathfile, '%s', 1 );

fclose(pathfile);


%% Remove old folder if existing
if ( exist(mainfolder,'dir') == 7 )

    %rmdir(mainfolder,'s');
    warning('Folder already existing');
    
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


%% Simulation file
amount = 10;

% create info file
infofilename = sprintf('%s/%s', mainfolder, simulationinfo);
infofilename = regexprep(infofilename, '**', num2str(i)); 
simfile = fopen(infofilename, 'w');
    
% overhead
dstr = date;
cstr = clock;
fprintf(simfile, '©2012 ETH Zuerich\nBambolei\nNicholas Eyring, Youri Popoff\nSimulation of trading in an artificial stock market\n\n\n\n');
fprintf(simfile, '                                                 **** SIMULATION ****\n\n');
    
fprintf(simfile, '                                                    Date:  %s\n', dstr);
fprintf(simfile, '                                                    Time:  %02.0f:%02.0f:%02.0f\n\n', 0, cstr(5), cstr(6));

fprintf(simfile, '                                   Number of simulations:  %u\n', amount);
fprintf(simfile, '                                         Simulation info:  %s/%s\n', tprefix, sinfo);
fprintf(simfile, '                                   Simulation parameters:  %s/%s\n\n', tprefix, sparam);

fclose(simfile);


digit = floor(log10(amount))+1;

addpath('Input');

    [SSM, SP, SPL] = init();
    
rmpath('Input');

for i = 1:1:amount

    simustr = sprintf('%0*.0f', digit, i);
    
    % create parameters file
    filename = sprintf('%s/%s', tprefix, sparam);
    filename = regexprep( filename, '**', simustr);
    save(filename, 'SSM', 'SP', 'SPL');
    
    % create info file
    infofilename = sprintf('%s/%s', tprefix, sinfo);
    infofilename = regexprep( infofilename, '**', simustr);
    file = fopen(infofilename, 'w');
    
    % overhead
    dstr = date;
    cstr = clock;
    fprintf(file, '©2012 ETH Zuerich\nBambolei\nNicholas Eyring, Youri Popoff\nSimulation of trading in an artificial stock market\n\n\n\n');
    fprintf(file, '                                     **** SIMULATION %s of %u ****\n\n', simustr, amount);
    
    fprintf(file, '                                                    Date:  %s\n', dstr);
    fprintf(file, '                                                    Time:  %02.0f:%02.0f:%02.0f\n\n', 0, cstr(5), cstr(6));
    
    % parameters
    fprintf(file, '                      Number of traders -           tnum:  %u\n',     SP.tnum);
    fprintf(file, '                       Amount of shares -      totShares:  %u\n',     SP.totShares);
    fprintf(file, '                         Starting price -             p0:  %.2f\n\n', SP.p0);
    
    fprintf(file, '            Mean of normal distribution -             mu:  %.4f\n',   SP.mu);
    fprintf(file, ' Initial std. deviation of normal dist. -          sigma:  %.4f\n',   SSM.sigma);
    fprintf(file, '  Parameter of exponential distribution -         lambda:  %.4f\n\n', SP.lambda);
    
    fprintf(file, '                             Total days -              M:  %u\n',     SP.M);
    fprintf(file, '                  Total time in seconds -              T:  %u\n\n',   SP.T);
    
    fprintf(file, '             Last tick iteration window -             dt:  %.2f\n\n', SP.dt);
    
    fprintf(file, '                    Empty book (On/Off) -        bkempty:  %u\n',     SP.bkempty);
    fprintf(file, '                 Entry refresh (On/Off) -     entrefresh:  %u\n',     SP.entrefresh);
    fprintf(file, '       Entry erasure when aged (On/Off) -         entage:  %u\n',     SP.entage);
    fprintf(file, '               Multiple shares (On/Off) -      mulshares:  %u\n',     SP.mulshares);
    fprintf(file, '           Volatility feedback (On/Off) -        volfeed:  %u\n\n',   SP.volfeed);
    
    fprintf(file, '                  Sigma constant factor -              k:  %.2f\n',   SP.k);
    fprintf(file, '             Buyer - Seller correlation -         korrbs:  %.2f\n',   SP.korrbs);
    fprintf(file, '            Old - New sigma correlation -          korrk:  %.2f\n',   SP.korrk);
    fprintf(file, '                   Maximum age of entry -             a0:  %.2f\n\n', SP.a0);
    
    
    fclose(file);
    
end

