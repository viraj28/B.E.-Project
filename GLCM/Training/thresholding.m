function I = thresholding(I3, thresh)
I =zeros(size(I3));
for i=1:size(I3,1)
    for j =1:size(I3,2)
        if (I3(i,j) > 135)
            I(i,j) = 1;
        end
    end
end
%I = bwareaopen(I, 5);
%I = imfill(I,'holes');
end