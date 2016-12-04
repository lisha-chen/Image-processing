function thresh=Huangs_Fuzzy(input)

% Huang's fuzzy thresholding method
% 
% 
% Refs:
% L.K. Huang, M.J. Wang, Image thresholding by minimizing the measure of fuzziness, 
% Pattern Recognition 28 (1995) 41¨C51.
%
%Author:Lisha.Chen
%

if nargin < 1 || nargin > 1
  error('Huangs_Fuzzy: input variables mismatch');
end	

% Check if input image is rgb and convert to a gray-level image
if ndims(input) == 3
  input = rgb2gray(input);
end 


doubleInput=double(input);
[m,n]=size(doubleInput);
mu=zeros(m,n);
S=zeros(m,n);
num=m*n;

minEntropy=1;

maxInput=max(max(doubleInput));
minInput=min(min(doubleInput));
C=maxInput-minInput;

sortInput=sort(doubleInput(:),'descend');

for k=minInput:1:maxInput
    threshTemp=k;
    threshIndex=find(sortInput>=threshTemp, 1, 'last' );
    meanFore=mean(sortInput(1:threshIndex));
    meanBack=mean(sortInput((threshIndex+1):num));

    for i=1:m
        for j=1:n
            
if doubleInput(i,j)<=threshTemp
    mu(i,j)=1/(1+abs(doubleInput(i,j)-meanBack)/C);
else
    mu(i,j)=1/(1+abs(doubleInput(i,j)-meanFore)/C);
end
 
            S(i,j)=-mu(i,j)*log(mu(i,j))-(1-mu(i,j))*log(1-mu(i,j));
        end
    end
    Entropy=sum(sum(S))/(num*log(2));
    if Entropy<minEntropy
        minEntropy=Entropy;
        thresh0=threshTemp;
    end
    
end

thresh=(thresh0-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput)));

end




