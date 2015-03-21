clc
%loading term document query 
M=load('data.txt');

%Applying singular value decomposition
[K,S,D] = svd(M);

%taking s largest singular values
s=2;

%modifyning K, S and D to KS, SS and DS respectively
KS=K(:,1:s);
SS=S(1:s,1:s);
DS=D(:,1:s);

%loading query vector
Q=load('query.txt');

%mapping query vector into Document Space
QS=Q'*KS*inv(SS);

%Preparing ranking matrix (1st -column document number, 2nd - ranking)
SimM=ones(1:length(DS(:,1)),2);

%comparing tranformed vector using standard cosine measure
for i=1:length(DS(:,1)),
   SimM(i,1)=i;   
   SimM(i,2)=dot(DS(i,:),QS)/((sqrt(dot(DS(i,:),DS(i,:))))*(sqrt(dot(QS,QS))));   
end

%sorting the results
sortrows(SimM,[2])