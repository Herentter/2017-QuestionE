clc
clear all
close all

figure(7)

plot(2,2,'ob');hold on;
plot(6,2,'ob');
plot(4,1,'ob');
plot(3,4,'ob');
plot(5,4,'ob');

plot([2 6],[2 2],'-g');
plot([2 4],[2 1],'-y');
plot([4 6],[1 2],'-y');
plot([2 3 5 6],[2 4 4 2],'-r');

x = 0.05;y = 0.05;
text(2+x,2-y,'A','color','r');
text(6+x,2-y,'B','color','r');

axis([1 7 0 5]);