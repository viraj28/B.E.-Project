function [inverseVariance_value]=ivariance(A)
inverseVariance_value=0;
for i=1:16
    for j=1:16
	if i==j || A(i,j)==0
		continue;
	end;
        inverseVariance_value=inverseVariance_value+(A(i,j)/power((i-j),2));
    end
end