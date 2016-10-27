rng(1);
u1 =0;
u2 =0;
l1=0;
l2=0;
for i=1:288
for j=21:40
f2(i,k) = feature_vector(i,j);
k = k+1;
end
k=1;
end
idx = kmeans(f2,2,'Distance','sqEuclidean');
cluster1 = f2((idx==1),:);
cluster2 = f2((idx==2),:);
for i=1:144
if(idx(i,1)==1)
u1=u1+1;
else
u2=u2+1;
end
end
for i=145:288
if(idx(i,1)==1)
l1=l1+1;
else
l2=l2+1;
end
end