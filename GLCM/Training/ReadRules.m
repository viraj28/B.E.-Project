clc;
clear;
content = fileread( 'rules.txt' ) ;
data = textscan( content, '%d ', 'HeaderLines', 0 ) ;
b=data{1,1};
[s,~]=size(b);
%for rules of type 1000 <-- 1 2 3
x=0;
y=1;
for i=1:s
    fprintf('Reading Rule %d of %d (Remaining %d)\n',i,s,s-i);
    if b(i,1)==10 || b(i,1)==11 || b(i,1)==12
        x=x+1;
        y=1;
        temp(x,1)=b(i,1);
    else
        temp(x,y+1)=temp(x,y);
        temp(x,y)=b(i,1);
        y=y+1;
    end
end;
[r,~]=size(temp);
fprintf('Total Rules Generated : %d\n',r);
clearvars -except temp;
save('temp.mat');