function thresh=MinError(input)

% Minimum error thresholding
% 
% 
% Refs:
% Kittler, J & Illingworth, J (1986), 
% Minimum error thresholding, Pattern Recognition 19: 41-47
% 
%Author:Lisha.Chen
%

if nargin < 1 || nargin > 1
  error('MinError: input variables mismatch');
end	

% Check if input image is rgb and convert to a gray-level image
if ndims(input) == 3
  input = rgb2gray(input);
end 

doubleInput=double(input);
[m,n]=size(doubleInput);
num=m*n;

minError=1E+20;

maxInput=max(max(doubleInput));
minInput=min(min(doubleInput));

sortInput=sort(doubleInput(:),'descend');


for k=minInput:1:maxInput
    threshTemp=k;
    threshIndex=find(sortInput>=threshTemp, 1, 'last' );
    sigmaFore=var(sortInput(1:threshIndex));
    sigmaBack=var(sortInput((threshIndex+1):num));
    numFore=length(sortInput(1:threshIndex));
    numBack=length(sortInput((threshIndex+1):num));
%     pFore=numFore/num;
%     pBack=numBack/num;
    minErrorTemp=1+numFore*log(sigmaFore)+numBack*log(sigmaBack)-...
        2*numFore*log(numFore)-2*numBack*log(numBack);
%     minErrorTemp=1+pFore*log(sigmaFore)+pBack*log(sigmaBack)-...
%         2*pFore*log(pFore)-2*pBack*log(pBack);
    
    if minError>minErrorTemp&&sigmaFore>eps&&sigmaBack>eps
        minError=minErrorTemp;
        thresh0=threshTemp;
    end
end
thresh=(thresh0-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput)));
%thresh=thresh0;
end
