clc;
clear;
temp = importdata( 'rulesW.txt' ) ;
fprintf('Total Rules Generated : %d\n',size(temp,1));
save('temp1.mat');