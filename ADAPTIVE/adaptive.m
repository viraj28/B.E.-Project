cm1 = zeros(1,9);
cm2 = zeros(1,9);
dmin = 0;
results = zeros(288,1);

rows = size(features,1);
cols = size(features,2);
nVect = rows;

cm1 = mean(features(1:nVect/2,:));
cm2 = mean(features((nVect/2)+1:nVect,:));

dmin = euclid(cm1,cm2);

sprintf('Initial Values');
cm1
cm2
dmin

for i=1:10
    for row=1:rows
        d1 = 0;
        d2 = 0;
        d1 = euclid(cm1,features(row,:));
        d2 = euclid(cm2,features(row,:));
        if ((d1 > dmin) && (d2 > dmin))
            cm1 =  cm1 + cm2 ;
            cm2 =   features(row,:);
            cm1 = cm1/2;
            dmin = euclid(cm1,cm2);
        else
            if d1 < d2
                cm1 = cm1 + features(row,:);
                cm1 = cm1/2;
                dmin = euclid(cm1,cm2);
            else
                cm2 = cm2 + features(row,:);
                cm2 = cm2/2;
                dmin = euclid(cm1,cm2);
            end
        end
    end
end

acc = 0;
for row=1:nVect
    d1 = 0;
    d2 = 0;
    d1 = euclid(cm1,features(row,:));
    d2 = euclid(cm2,features(row,:));
    if d1 < d2
        if row<=nVect/2;
            results(row)=11;
            acc = acc + 1;
        else
            if row>nVect/2;
                results(row)=12;
                acc = acc + 1;
            end
        end
    end
end

acc = acc/size(features,1) * 100;
sprintf('Final Values:\n');
cm1
cm2
dmin
acc
