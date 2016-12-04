function thresh=meanPeak(input)

% minimum value in valley thresholding
% 
%
% Refs(require supplement):
%
%
%Author:Lisha.Chen
%

if nargin < 1 || nargin > 1
  error('meanPeak: input variables mismatch');
end	

% Check if input image is rgb and convert to a gray-level image
if ndims(input) == 3
  input = rgb2gray(input);
end 

doubleInput=double(input);

[hist,~] = imhist(uint8(input));

iteration=0;
while isDimodal(hist)==false
histSmooth=zeros(length(hist),1);
histSmooth(2:end-1)=(hist(1:end-2)+hist(2:end-1)+hist(3:end))/3;
histSmooth(1)=(2*hist(1)+hist(2))/3;
histSmooth(end)=(2*hist(end)+hist(end-1))/3;
hist=histSmooth;
iteration=iteration+1;
if iteration>=1000
    error('cannot acquire double peaks');
end
end

peakIndex1=find((hist(1:end-2)-hist(2:end-1))<0&(hist(3:end)-hist(2:end-1))<0,1,'first');
peakIndex2=find((hist(1:end-2)-hist(2:end-1))<0&(hist(3:end)-hist(2:end-1))<0,1,'last');

thresh0=(peakIndex1+peakIndex2)/2;

thresh=(thresh0-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput)));
end


function y=isDimodal(hist)
peakIndex=find((hist(1:end-2)-hist(2:end-1)<0)&(hist(3:end)-hist(2:end-1)<0));
if length(peakIndex)==2
    y=true;
else y=false;
end
end