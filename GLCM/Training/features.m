function [feature_vector]=features(glcm)
[no,~]=size(glcm);
feature_vector=cell(no,140);
for i=1:no
	fprintf('Extracting feature for Image %d out of %d\n',i,no);
    for j=1:20
        glcm_features=graycoprops(glcm{i,j},{'Energy','Contrast','Homogeneity'});
        step_value=0;
        [step_value]=step(glcm{i,j});
        feature_vector{i,j}=step_value;
        feature_vector{i,j+20}=glcm_features.Contrast;
        entropy_value=0;
        entropy_value=entropy(glcm{i,j});
        feature_vector{i,j+40}=entropy_value;
        feature_vector{i,j+60}=glcm_features.Energy;
        feature_vector{i,j+80}=glcm_features.Homogeneity;
%         [moment_value]=moment(glcm{i,j});
        p=imhist(glcm{i,j},256);
        [V, unv] = statmoments(p,  3);
        feature_vector{i,j+100}=V(1,3);
        [inverseVariance_value]=ivariance(glcm{i,j});
        feature_vector{i,j+120}=inverseVariance_value;
    end
    step_value=0;
end