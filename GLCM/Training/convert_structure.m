function[points,F,cut]=convert_structure(feature_vector,type)
% A=struct(values,[],class,[]);
[no,~]=size(feature_vector);
test=struct;
for i=1:140
    for j=1:no
        test(j).value=feature_vector{j,i};
        test(j).class=type(j);
    end
        [cut_points,A]=presage(test);
        cut{i}=cut_points;
        [~,points(i)]=size(cut_points);
        F{i}=A;
end