clc;
clear;
for i=1:144         %%For Benign
    type(i)=1;
end;
for i=145:288       %%For Malignant
    type(i)=2;
end;
%%%% 0 :- Normal 1 :- Benign 2 :- Malignant
[pre_processed]=segment();                                          %%%%PATH%%%%
[glcm]=glcm_matrix(pre_processed);
[feature_vector]=features(glcm);
[points,F,cut]=convert_structure(feature_vector,type);
[opt_feature1,result]=assign_labels(F,feature_vector,points,cut,type,96);
save('train.mat');