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


figure(2);

N = 1000 ;
x = 1:N ;
y = repmat(NaN,1,N) ;
h = plot(x,y,'b-') ;

set(gcf,'doublebuffer','on') ; % remove flicker
set(gca,'xlim',[0 N],'ylim',[-1.1 1.1]) ;

%%
%set(h,'erasemode','xor') if active no: drawnow
%%

title('Press a key ...') ;
pause
for i=1:N,
  y(i) = sin(2*pi*0.5*(i/100)) ;
  %set(h,'ydata',y) ;
  h = plot(x,y,'b-') ;
  drawnow
end