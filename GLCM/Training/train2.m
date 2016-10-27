clc;
close all;
clear all;
    
I = imread('C:\BE Project\jyoti\GLCM\Training\train\11_A_1177_1.RIGHT_MLO.LJPEG.png');
[m, n] = size(I);
cc = bwconncomp(I, 8);
thresh =135;
%while thresh <256
    hold on;
    I3 = thresholding(I,thresh);
    subplot(1,2,1);
    imshow(I);
    subplot(1,2,2);
    imshow(I3);
    thresh = thresh+1;
    thresh
 
%end
