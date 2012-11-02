file = fopen('param.txt','r');

ctrl = 0;
stru = '';
depth = '';
frewind(file);
space = '                ';
[ctrl, stru] = paramSweep(ctrl, file, stru, depth, space );

fclose(file);

ctrl
stru