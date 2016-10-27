clear;
clc;
load('C:\BE Project\jyoti\GLCM\training\train.mat')
for i=1:size(ass,1)
    for j=1:size(type,2)
        X(j,i)=feature_vector{j,ass(i,1)};
    end;
end;