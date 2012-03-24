# MATLAB FS12 – Research Plan (Template)
(text between brackets to be removed)

> * Group Name: Bambolei
> * Group participants names: Nicholas Eyring, Youri Popoff
> * Project Title: Simulation of Trading in an artificial Stock Market


## General Introduction

	Over the past decades the financial services industry has firmly established itself as a key player in modern society.
Its successes and more importantly its failures have persisted to have broad repercussions all over the world.

	At the heart of the financial system lies the stock market.
We believe that a good analytic model of the trading of shares on the stock market could be a very useful tool to help prevent financially unfavorable situations.
History has shown us time and again that markets do crash and that the price of picking up the pieces is a serious burden on economic growth and human progress.


## The Model

	The main output of the model will be a graph displaying the evolution of the transaction price of a particular stock over time.
We will therefore define time as the independent variable and price as the dependent variable.

	Our model consists of a specific number of traders who each have a specific amount of shares and cash.
Once the market is open, a trader is randomly chosen for issuing an order. The trader can issue either a buy or a sell order with a given probability.
The price of the order depends on the prices of the previous orders and eventually on the volatility of the market in the past.
A transaction will occur if there is an overlap between bid and asking prices. Otherwise the order is stored “in the book” and no transaction occurs.

	The market structure we have chosen is known as a double-auction market using the limit order book for price formation.
Gathering from the papers which we have read, this structure is a remarkably realistic model of a real stock market.
It is much better than the clearing house model which clears the market periodically at the supply/demand price equilibrium.


## Fundamental Questions

	* How does past market volatility affect the future price of a stock?
	* How does the initial price/number of stocks affect future market activity?
	
	
## Further possibilities

	* What impact does emptying the book have on the market?
	* How does adding trader personalities (conservative vs. risk taker) affect the outcome?
	* What impact does the number of stocks per transaction have on the market?
	

## Expected Results

	* Price should be more stable if past market volatility is taken into account.
	

## References 

	* Modeling and simulation of a double auction artificial financial market – Raberto 2005
	* Price Variations in a Stock Market with Many Agents – Bak 1996
	* Scaling and criticality in a stochastic multi-agent model of a financial market – Lux 1999
	* Thermodynamic limits of macroeconomic or financial models:
	One- and two-parameter Poisson-Dirichlet models – Aoki 2007
	* Agent-based simulation of a financial market – Raberto 2001
	

## Research Methods

	We will be using the agent-based simulation method.
The agents will be represented by the traders, each of which will have an initial set of shares and liquidities which will evolve over time.
The so-called playground will be the market in which the different agents will interact.


## Other

(no data sets are necessary)
