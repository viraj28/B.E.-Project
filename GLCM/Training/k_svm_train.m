load('train.mat');

rng(1);
feature_vector=cell2mat(feature_vector);          % did this because conversion to double from cell is not possible.
idx = zeros(288,140);                             % made a vector to store kmeans result and later subtraction result.
%classes = zeros(288,1);                           % made to store the 1st column of result vector...although didnt use it.
for i=1:140
    idx(:,i) = kmeans(feature_vector(:,i),2,'Distance','cityblock');     % clustering on each column of feature vector.
end
classes = transpose(type);
bORm = kmeans(classes,2,'Distance','cityblock');                         % storing kmeans result of 1st column of result vector..i.e benign(11) or malignent(12)

for i=1:288
    if bORm(i,1)==2
        bORm(i,1)=1;
    else
        bORm(i,1)=2;
    end
end
for i=1:140
    idx1(:,i) = bORm-idx(:,i);                     % subtracting kmean of feature vector(each column)from ....bORm.
end

c = zeros(1,140);                      % counter to store count how many rightly classified images.
p = zeros(1,140);                      % to store percent of each feature 
for i=1:140
    for j=1:288
        if(idx1(j,i)==0)
            c(1,i)= c(1,i)+1;
        end
        p(1,i) = (c(1,i)/288) * 100;   
    end
end
        
large = zeros(1,2);               % to store largest 10 percentages
max=0;
for j=1:2                         % iterations to get maximum 10 percentages and their indexes
    max = p(1,1);
    index = 1;
    for i=1:140
        if(max<p(1,i))
            max=p(1,i);
            index=i;
        end
    end
    large(1,j) = max;
    indice(1,j) = index;           % to store indexes of those percentages.
    p(1,index) = 0;
end

opt_feature = zeros(288,2);       % to store final optimized feature vector
%opt_feature1 = zeros(10,289);

for i=1:2
    opt_feature(:,i) = feature_vector(:,indice(1,i));
end

Y = ones(288,1);
Y(145:288) = 2 ;

SVMModel = fitcsvm(opt_feature,Y,'KernelFunction','rbf','Standardize',true,'ClassNames',{'1','2'});




