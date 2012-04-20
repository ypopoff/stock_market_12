clear all; clc;

hold on;

A = exprnd(20,100000,1);
subplot(3,2,1); hist(A,100);
subplot(3,2,2); A = sort(A, 'descend'); plot(A,[1:1:100000]);

B = normrnd(0,1,100000,1);
subplot(3,2,3); hist(B,100);
subplot(3,2,4); B = sort(B, 'descend'); plot(B,[1:1:100000]);

lambda = 300;
C = 0.01*rand(100000,1);
D = lambda * exp(-lambda * C);
subplot(3,2,5); hist(D,100);
D = sort(D,'descend');
subplot(3,2,6); plot(D,[1:1:100000]);