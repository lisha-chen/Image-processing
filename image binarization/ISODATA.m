function thresh=ISODATA(input)

% ISODATA (intermeans) method for thresholding
% 
% 
% Refs:
% Ridler, TW & Calvard, S (1978), Picture thresholding using an iterative selection method, 
% IEEE Transactions on Systems, Man and Cybernetics 8: 630-632
% 
%Author:Lisha.Chen
%

if nargin < 1 || nargin > 1
  error('ISODATA: input variables mismatch');
end	

% Check if input image is rgb and convert to a gray-level image
if ndims(input) == 3
  input = rgb2gray(input);
end 

epsilon=1E-5;
doubleInput=double(input);
[m,n]=size(doubleInput);
num=m*n;
maxInput=max(max(doubleInput));
minInput=min(min(doubleInput));
thresh0=(maxInput+minInput)/2;
sortInput=sort(doubleInput(:),'descend');
threshIndex=find(sortInput>=thresh0, 1, 'last' );
meanFore=mean(sortInput(1:threshIndex));
meanBack=mean(sortInput((threshIndex+1):num));
threshTemp=thresh0;
newThreshTemp=(meanFore+meanBack)/2;

while(abs(newThreshTemp-threshTemp)>epsilon)
threshTemp=newThreshTemp;
threshIndex=find(sortInput>=threshTemp, 1, 'last' );
meanFore=mean(sortInput(1:threshIndex));
meanBack=mean(sortInput((threshIndex+1):num));
newThreshTemp=(meanFore+meanBack)/2;
end
thresh=(threshTemp-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput)));
end