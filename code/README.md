# Code Folder !!! OUTDATED !!! 

##Hierarchy

* test.m
* init.m
* main.m
	* buyer.m
	* seller.m


##Script test.m

Test application of the random distribution functions, rand(n), exprnd(n) & normrnd(n).


##Script init.m

Contains all initial parameters.
Creates trader matrix & empty book matrixes.


##Script main.m

Determines trading period and calls buyer or seller function to create entries in the Stock Market book.


##Function buyer.m

Completes the tasks of the buyer (stat = 0).
Calculates the price of the bid.
Checks if transaction needs to be executed and calls transaction function.


##Function seller.m

Completes the tasks of the seller (stat = 1).
Calculates the price of the asked price.
Checks if transaction needs to be executed and calls transaction function.