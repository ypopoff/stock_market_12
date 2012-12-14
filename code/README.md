# How to run the code

## General advice
The simulation(s) can be started by running the script _code/control.m_ in MatLab.
An automated implementation takes care of creating the input, running the simulation and plotting the results.


## Changing the sweep
The sweep definition can be modified in _code/Input/param.txt_.

The structure is (example):

 <code>[Swept parameter] [initial value] [increment] [final value]</code>

 
The syntax described here should be respected, for the code to function as intended.

- Additional space characters or tabulation characters may be placed between the different columns.
- However, a (superfluous) carriage return at the end of the file will hinder the generation of the input.
- The parameters defined should also be existent.

Further (valid) examples of parameter files can be seen in _code/Data/param**.txt_; these were the parameter sweep definitions used
for the results presented in the paper.
(When using one of these _param**.txt_ files, the _**_ should be removed and the file should be copied in the _code/Input/_ folder).

## Troubleshooting
- The input is not generated: remove the carriage return at the end of _code/Input/param.txt_.
- The simulations all fail: check the error message in the simulation report files: _code/Data/Simulation**/Sim**/sim**report.txt_.