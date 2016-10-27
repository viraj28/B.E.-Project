function [glcm]=glcm_matrix(pre_processed)
[no,~]=size(pre_processed);
glcm=cell(no,20);
for i=1:no
    fprintf('Creating GLCM Matrix for Image %d out of %d\n',i,no);
    glcm{i,1}  = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[0 1]);   %0 degree
    glcm{i,2}  = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[0 2]);
    glcm{i,3}  = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[0 3]);
    glcm{i,4}  = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[0 4]);
    glcm{i,5}  = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[0 5]);
    glcm{i,6}  = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-1 1]);  %45 degree
    glcm{i,7}  = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-2 2]);
    glcm{i,8}  = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-3 3]);
    glcm{i,9}  = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-4 4]);
    glcm{i,10} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-5 5]);
    glcm{i,11} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-1 0]);   %90 degree
    glcm{i,12} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-2 0]);
    glcm{i,13} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-3 0]);
    glcm{i,14} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-4 0]);
    glcm{i,15} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-5 0]);
    glcm{i,16} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-1 -1]);    %135 degree
    glcm{i,17} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-2 -2]);
    glcm{i,18} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-3 -3]);
    glcm{i,19} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-4 -4]);
    glcm{i,20} = graycomatrix(pre_processed{i},'GrayLimits',[0 1],'NumLevels',16,'Offset',[-5 -5]);
end
