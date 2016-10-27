function[pre_processed]=segment()
load 'centre.mat';
dirName='C:\BE Project\jyoti\GLCM\Training\train';

files = dir( fullfile(dirName,'*.png') );   %# list all *.xyz files
files = {files.name}';                      %'# file names
no=numel(files);


for fil=1:no                            %# 1:no_of_imgs
    fname = fullfile(dirName,files{fil});     %# full path to image with name
    fprintf('Training Image %d out of %d : %s\n',fil,numel(files),fname);
    csize=size(centre);
    for i=1:csize(1)
        if strcmp(centre{i,1},files{fil,1})==1
            cen=i;
            break;
        end;
    end;
    I=imread(fname);
    I=uint8(I/256);
%     I=cropRect(I,centre{cen,2},centre{cen,3});
    I=imcrop(I,[centre{cen,2}-256 centre{cen,3}-256 511 511]);
    I=histeq(I,256);
    pre_processed{fil}=I;
end;
