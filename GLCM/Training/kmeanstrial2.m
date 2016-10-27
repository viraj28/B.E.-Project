%feature_vector=cell2mat(feature_vector);
%X=feature_vector;
y=zeros(288,9);
y(:,1) = feature_vector(:,34);
y(:,2) = feature_vector(:,35);
y(:,3) = feature_vector(:,38);
y(:,4) = feature_vector(:,69);
y(:,5) = feature_vector(:,89);
y(:,6) = feature_vector(:,94);
y(:,7) = feature_vector(:,95);
y(:,8) = feature_vector(:,131);
y(:,9) = feature_vector(:,136);
X=y;
%initialization
dif1=zeros(288,9);
dif2=zeros(288,9);
c1=zeros(2,9);
c2=zeros(2,9);
c1(1,:)=X(30,:);         %initial clusters
c2(1,:)=X(255,:);
totc1(1,:)=c1(1,:);
totc2(1,:)=c2(1,:);
w=2;
sum1=zeros(288,1);
sum2=zeros(288,1);
Arr1=zeros(288,1);
Arr2=zeros(288,1);
k1=1;
k2=1;
sumc1=zeros(1,9);
sumc2=zeros(1,9);
z=1;

while(w~=9)
for i=1:288
    for j=1:9
        dif1(i,j)=abs(c1(z,j)-X(i,j));  %subtract each row from cluster centre 1
        dif2(i,j)=abs(c2(z,j)-X(i,j));  %subtract each row from cluster centre 2
        sum1(i,1)=sum1(i,1)+dif1(i,j);  %calculate sum of differences to check which cluster it is near to
        sum2(i,1)=sum2(i,1)+dif2(i,j);  %calculate sum of differences to check which cluster it is near to
    end
    %sum1=abs(sum1);
    %sum2=abs(sum2);
    if(sum1(i,1)<sum2(i,1))   %store indices of images belonging to cluster 1
        Arr1(i,1)= i;
    end
    if(sum1(i,1)>sum2(i,1))   %store indices of images belonging to cluster 2
        Arr2(i,1)= i;
    end
    if(Arr1(i,1)~=0)           % calculate count of images in cluster 1
        indice1(1,k1)=Arr1(i,1);
        k1=k1+1;
    end
    if(Arr2(i,1)~=0)           % calculate count of images in cluster 2
        indice2(1,k2)=Arr2(i,1);
        k2=k2+1;
    end  
end



for j=1:9                      %calculate new cluster centres
    for l=1:k1-1               
        sumc1(1,j)=sumc1(1,j)+X(indice1(1,l),j);
    end
    for l=1:k2-1                
        sumc2(1,j)=sumc2(1,j)+X(indice2(1,l),j);
    end
    c1(z+1,j)=sumc1(1,j)/(k1-1);
    c2(z+1,j)=sumc2(1,j)/(k2-1);
end
z=z+1;
totc1(w,:)=c1(z,:);
totc2(w,:)=c2(z,:);
%for(i=1:w-1)
 %   for j=1:140
  %      if(totc1(i,j)==totc1(i+1,j) && totc2(i,j)==totc2(i+1,j))
   %         break;
    %    end
    %end
%end
w=w+1;
k1=k1-1;
k2=k2-1;
if(w<9)
    k1=1;
    k2=1;
    sum1=zeros(288,1);
sum2=zeros(288,1);
Arr1=zeros(288,1);
Arr2=zeros(288,1);
sumc1=zeros(1,9);
sumc2=zeros(1,9);
clear indice1;
clear indice2;
end
    


end


    
    
    
        