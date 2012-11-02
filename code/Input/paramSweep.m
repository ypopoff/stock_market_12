%©2012 ETH Zürich
%Bambolei
%Nicholas Eyring, Youri Popoff
%Simulation of trading in an artificial stock market


function [ ctrl ] = paramSweep( SSM, SP, SPL, path, simfold, sparam, sinfo, ctrl, file, depth, space, tree )
%PARAMSWEEP Parameter sweep recursion function


    depth = sprintf( '%s%s', depth, space );                                % tree line spacing
    

    if feof(file) == 0
        
        pos1 = ftell(file);                                                 % save actual position in file

        var = fscanf(file, '%s', 1 );                                       % read line
        startval = fscanf(file, '%f', 1);
        incval = fscanf(file, '%f', 1);
        endval = fscanf(file, '%f', 1);

        
        %% Loop of parameter set
        for i = startval:incval:endval

            
            exec = sprintf( '%s = %u', var, i );                            % change to execute
            eval( [ exec, ';' ] );                                          % evaluate expression
           
            
            %% Tree
            stru = sprintf( '%s%s\n', depth, exec );
            fprintf( tree, stru );                                          % add line in tree
            
            
            %% Recursion
            [ ctrl ] = paramSweep( SSM, SP, SPL, path, simfold, sparam, sinfo, ctrl, file, depth, space, tree );

            
        end
        
        fseek(file,pos1,'bof');

        
    else
        
        
        %% Tree
        stru = sprintf( '%s=> simulation %u\n', depth, ctrl );
        fprintf( tree, stru );                                              % add line in tree
        
        
        %% Saving input file
        savefile( SSM, SP, SPL, path, simfold, sparam, sinfo, ctrl );
        
        ctrl = ctrl + 1;                                                    % increment simulation index
        
    
    end

end

