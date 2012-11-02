%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ctrl ] = paramSweepCall( SSM, SP, SPL, path, simfold, sparam, sinfo, parfold, spr, stru )
%PARAMSWEEPCALL Creates the simulation input files

    cd( '../' );
    
        parampath = sprintf( '%s/%s', parfold, spr );
        file = fopen( parampath, 'r' );                                     % file containing sweep information
        treepath = sprintf( '%s/%s', path, stru );
        tree = fopen( treepath, 'w' );                                      % file with simulation structure
    
    cd( 'Input/' );
    
    %% Initialise simulation structure
    depth = '';
    space = '                ';
    
    
    %% Paramater sweep recursion
    ctrl = 0;                                                               % index of simulation
    
    frewind( file );
    [ ctrl ] = paramSweep( SSM, SP, SPL, path, simfold, sparam, sinfo, ctrl, file, depth, space, tree );

    
    fclose( tree );
    fclose( file );
    

end

