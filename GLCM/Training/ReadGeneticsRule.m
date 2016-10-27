clc;
clear;
temp = importdata( 'rulesG.txt' ) ;
fprintf('Total Rules Generated : %d\n',size(temp,1));
save('temp2.mat');