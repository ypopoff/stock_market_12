function [ ctrl, stru ] = paramSweep( ctrl, file, stru, depth, space )
%PARAMSWEEP Summary of this function goes here
%   Detailed explanation goes here

    if feof(file) == 0
        
        depth = sprintf( '%s%s', depth, space );
        pos1 = ftell(file);

        var = fscanf(file, '%s', 1 );
        startval = fscanf(file, '%f', 1);
        incval = fscanf(file, '%f', 1);
        endval = fscanf(file, '%f', 1);

        for i = startval:incval:endval

            exec = sprintf( '%s = %u', var, i );
            stru = sprintf( '%s%s%s\n', stru, depth, exec );
            
            
            [ ctrl, stru ] = paramSweep( ctrl, file, stru, depth, space );

        end
        
        fseek(file,pos1,'bof');

    else
        
        depth = sprintf( '%s%s', depth, space );
        stru = sprintf( '%s%s=> simulation %u\n', stru, depth, ctrl );
        ctrl = ctrl + 1;
        
        
    end

end

