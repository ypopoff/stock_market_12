%test
tic
x = zeros(1000,1);
for i = 1:1000
    x(i) = i^2;
end
toc


tic
y = 1:1:1000;
y = y .^2;
toc