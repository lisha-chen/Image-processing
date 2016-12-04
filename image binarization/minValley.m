function thresh=minValley(input)

% minimum value in valley thresholding
% 
%
% Refs:
%
% J. M. S. Prewitt and M. L. Mendelsohn, 
% The analysis of cell images,
% innnals of the New York Academy of Sciences, 
% vol. 128, pp. 1035-1053, 1966.
% 
% C. A. Glasbey, 
% An analysis of histogram-based thresholding algorithms,
% CVGIP: Graphical Models and Image Processing, 
% vol. 55, pp. 532-537, 1993.
%
%Author:Lisha.Chen
%

if nargin < 1 || nargin > 1
  error('minValley: input variables mismatch');
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
valleyIndex=find((hist(peakIndex1:peakIndex2-2)-hist(peakIndex1+1:peakIndex2-1))>=0....
&(hist(peakIndex1+2:peakIndex2)-hist(peakIndex1+1:peakIndex2-1))>=0,1,'first');
if isempty(valleyIndex)
    error('cannot acquire valley');
end
thresh0=valleyIndex+peakIndex1;

thresh=(thresh0-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput)));
end


function y=isDimodal(hist)
peakIndex=find((hist(1:end-2)-hist(2:end-1)<0)&(hist(3:end)-hist(2:end-1)<0));
if length(peakIndex)==2
    y=true;
else y=false;
end
end
