clear;
%%%%%%%%%%%%%%%%%%%%ftry frules %%%%%
clc;
clear;
load train.mat
load temp.mat
frules=temp;
ftry=result;
clearvars -except ftry frules
%%%%%%%%%%%%%%%%%%
nfrules=sum(frules~=0,2);
fruler=size(frules,1); %Number of Rules generated in the rules.txt file
ftryr=size(ftry,1); %Number of transactions in the try.txt file

%%To calculate support of A,B and (A and B)
for k=1:fruler
%k=2;
    fprintf('%d %d\n',k,fruler);
    currentA=[];
    currentAandB=[];
    countA(k)=0;
    countB(k)=0;
    countAandB(k)=0;
    countAandBnot(k)=0;
    nlhs=nfrules(k);
    for i=1:nlhs-1
        currentA(i)=frules(k,i);
    end
    currentB=frules(k,nlhs);
    for i=1:nlhs
        currentAandB(i)=frules(k,i);
    end
    
    for i=1:ftryr
        tempo=ftry(i,:);
        if sum(ismember(tempo,currentA))==(nlhs-1)
            countA(k)=countA(k)+1;
        end
        if sum(ismember(tempo,currentB))==1
            countB(k)=countB(k)+1;
        end
         if sum(ismember(tempo,currentAandB))==nlhs
            countAandB(k)=countAandB(k)+1;
         end
        if (sum(ismember(tempo,currentA))~=(nlhs-1) &&  sum(ismember(tempo,currentB))~=1)
            countAandBnot(k)=countAandBnot(k)+1;
        end
        
         
    end
    
end

%cosine
for i=1:fruler
    fprintf('Cosine %d %d\n',i,fruler);
    cosine(i,1)=countAandB(i)/sqrt(countA(i)*countB(i));
end

%jaccard
for i=1:fruler
    fprintf('%Jaccard d %d\n',i,fruler);
    jaccard(i,1)=countAandB(i)/(countA(i)+countB(i)-countAandB(i));
end

%accuracy
for i=1:fruler
    fprintf('Accuracy %d %d\n',i,fruler);
    accuracy(i,1)=(countAandB(i)+countAandBnot(i))/ftryr;
end

%all-confidence
for i=1:fruler
    fprintf('Confidence %d %d\n',i,fruler);
    all_conf(i,1)=min(countAandB(i)/countB(i),countAandB(i)/countA(i));
end

 %write to file
 
genetics_cosine=sortrows(unique(cosine));
genetics_conf=sortrows(unique(all_conf));
genetics_jaccard=sortrows(unique(jaccard));
genetics_Accuracy=sortrows(unique(accuracy));
threshold=0.02;
f1 = 'rulesG.txt'; 
fid1 = fopen(f1,'w');  
g_count=0;
for i=1:fruler
    fprintf('Genetics %d %d\n',i,fruler);
    if (cosine(i)>=threshold && all_conf(i)>=threshold && jaccard(i)>=threshold && accuracy(i)>=threshold)
        dlmwrite(f1,frules(i,:),'-append',...  %# Print the matrix
         'delimiter',' ',...
         'newline','pc');
        g_count=g_count+1;
    end
end
fclose(fid1);

 
%%Lift ,completeness,certainty factor

for i=1:fruler
    fprintf('lift %d %d\n',i,fruler);
    lift(i,1)=countAandB(i)/(countA(i)*countB(i)/ftryr);
end


for i=1:fruler
    fprintf('completeness %d %d\n',i,fruler);
    completeness(i,1)=countAandB(i)/countA(i);
end
for i=1:fruler
    fprintf('cetainity %d %d\n',i,fruler);
    part1=(countAandB(i)/countA(i)-countB(i)/ftryr)/(1-(countB(i)/ftryr));
part2=(countAandB(i)/countB(i)-countA(i)/ftryr)/(1-(countA(i)/ftryr));
certainty(i,1)=max(part1,part2);
end

for i=1:fruler
    fprintf('support %d %d\n',i,fruler);
    support(i,1)=countAandB(i)/ftryr;
end
       
for i=1:fruler
    fprintf('confidence %d %d\n',i,fruler);
    confidence(i,1)=countAandB(i)/countA(i);
end
       
%%Weight calculation
for i=1:fruler
    fprintf('lift %d %d\n',i,fruler);
    if lift(i)>1
    w(i,1)=support(i)*confidence(i)*completeness(i)*certainty(i);
    end
    if lift(i)<1
    w(i,1)=support(i)*confidence(i)*completeness(i)*certainty(i)/4;
    end
        
end

w_threshold=0.01;
y=0;x=0;
for i=1:fruler
    if(w(i,1)>=w_threshold)
        y=y+1;
    else
        x=x+1;
    end
end
f1 = 'rulesW.txt'; 
fid1 = fopen(f1,'w');
 
for i=1:fruler
       if(w(i,1)>=w_threshold)
        dlmwrite(f1,frules(i,:),'-append',...  %# Print the matrix
         'delimiter',' ',...
         'newline','pc');
       end   
end
fclose(fid1);
weight=sortrows(unique(w));
save optimization.mat
