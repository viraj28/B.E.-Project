function[cut_points,A]=presage(A)

minperprint=2;
mintofuse=0.75;

[A]=sortstructure(A);
[w, n]=size(A);

n1=n;

cut_points(1)=0;
p=2;
for i=1:n-1
    if A(i).class~=A(i+1).class         %Condition-1
        cut_points(p)=i;
        p=p+1;
    end;
end;
cut_points(p)=n;

[~,n]=size(cut_points);
cut_points1=cut_points;

for i=1:n-1
    if(cut_points1(i)==1000)
        continue;
    end;
    if (cut_points(i+1)-cut_points(i))<minperprint     %Condition-2
            cut_points1(i+1)=1000;
    end
end
cut_points1(cut_points1==1000) = [];
cut_points=cut_points1;

[w, n]=size(cut_points);
i=1;
while i<=n-2                                %Condition-3
    C_10=0;
    C_11=0;
    C_12=0;
    C_20=0;
    C_21=0;
    C_22=0;
    for j=(cut_points(i)+1):cut_points(i+1)
        if A(j).class==1
            C_11=C_11+1;
        elseif A(j).class==0
            C_10=C_10+1;
        else
            C_12=C_12+1;       
        end
    end
    for j=cut_points(i+1)+1:cut_points(i+2)
        if A(j).class==1
            C_21=C_21+1;
        elseif A(j).class==0
            C_20=C_20+1;
        else
            C_22=C_22+1;
        end
    end
    M1=max(max(C_10,C_11),C_12);
    if C_10==M1
        flag1=0;
    elseif C_11==M1
        flag1=1;
    else
        flag1=2;
    end;
    M2=max(max(C_20,C_21),C_22);
    if C_20==M2
        flag2=0;
    elseif C_21==M2
        flag2=1;
    else
        flag2=2;
    end;
    T1=cut_points(i+1)-cut_points(i);
    T2=cut_points(i+2)-cut_points(i+1);
    if(flag1==flag2)
        if M1==M2 && M1/T1>=mintofuse && M2/T2>=mintofuse
            cut_points(i+1)=[];
            i=1;
            [w, n]=size(cut_points);
        end;
    end
        i=i+1;
end
cut_points(cut_points==n1) = [];

