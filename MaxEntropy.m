function thresh=MaxEntropy(input)

% max Entropy thresholding
% 
% 
% Refs(require supplement):
%
%
%
%Author:Lisha.Chen
%

if nargin < 1 || nargin > 1
  error('MaxEntropy: input variables mismatch');
end	

% Check if input image is rgb and convert to a gray-level image
if ndims(input) == 3
  input = rgb2gray(input);
end 

doubleInput=double(input);
[m,n]=size(doubleInput);
num=m*n;

maxEntropy=0;

maxInput=max(max(doubleInput));
minInput=min(min(doubleInput));

sortInput=sort(doubleInput(:),'descend');

for k=(minInput+1):1:(maxInput-1)
    threshTemp=k;
    threshIndex=find(sortInput>=threshTemp, 1, 'last' );
    entropyFore=entropy(uint8(sortInput(1:threshIndex)));
    entropyBack=entropy(uint8(sortInput((threshIndex+1):num)));
    if maxEntropy<entropyFore+entropyBack
        maxEntropy=entropyFore+entropyBack;
        thresh0=threshTemp;
    end
end
thresh=(thresh0-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput)));

end