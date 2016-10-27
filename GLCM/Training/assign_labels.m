function[opt_feature1,result]=assign_labels(F,feature_vector,points,cut,type,cut_points)
[no,~]=size(feature_vector);
p=1;
sizep=size(points)
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
        
large = zeros(1,10);               % to store largest 10 percentages
max=0;
for j=1:10                         % iterations to get maximum 10 percentages and their indexes
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

opt_feature = zeros(288,10);       % to store final optimized feature vector
opt_feature1 = zeros(10,289);

for i=1:10
    opt_feature(:,i) = feature_vector(:,indice(1,i));
end

%opt_feature = opt_feature *100;


opt_feature = transpose(opt_feature);

 for i=1:288
  opt_feature1(:,i+1) = opt_feature(:,i);
 end
 opt_feature = opt_feature * 100;
 opt_feature = int64(opt_feature);
opt_feature1(:,1) = indice(1,:);
ass = opt_feature1;



%feature_vector=mat2cell(feature_vector);

[s,~]=size(ass);
fprintf('Total %d Features Selected\n',s);

%for j=1:no
 %   z=51;
  %  result(j,1)=type(j)+10;
   % for k=1:s
    %    for l=2:cut_points
	%	if feature_vector(j,ass(k,1))>=ass(k,l) && feature_vector(j,ass(k,1))<ass(k,l+1)
     %       		result(j,k+1)=z+l-2;
      %  	end
%end;
 %       if feature_vector(j,ass(k,1))>=ass(k,cut_points+1)
  %          	result(j,k+1)=z+cut_points-1;
   %     end
    %    z=z+cut_points;
    %end
%end
opt_feature = transpose(opt_feature);
for i=145:288
    opt_feature(i,:) = opt_feature(i,:) * 2;
end

for i =1:10
    result(:,i+1) = opt_feature(:,i);
end

for i=1:144
    result(i,1)=11;
end

for i=145:288
    result(i,1) = 12;
end
nRowv = size(result, 1);
nColv = size(result, 2);

fName = 'try.txt';                 %# A file name
fid = fopen(fName,'w');            %# Open the file           

j=1; 
for i=1:nRowv
    while j<=nColv & result(i,j)>=0 
        labelc(j)=result(i,j);
        j=j+1;
    end
    dlmwrite(fName,labelc,'-append',...  %# Print the matrix
         'delimiter',',',...
         'newline','pc');
    clear labelc;
    j=1;
end
