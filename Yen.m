function thresh=Yen(input)

% Yen thresholding
% 
% 
% Refs:
% 1) Yen J.C., Chang F.J., and Chang S. (1995) 
% A New Criterion  for Automatic Multilevel Thresholding,
% IEEE Trans. on Image  Processing, 
% 4(3): 370-378
% 
% 2) Sezgin M. and Sankur B. (2004) 
% Survey over Image Thresholding Techniques and Quantitative Performance Evaluation, 
% Journal of  Electronic Imaging, 13(1): 146-165
%

if nargin < 1 || nargin > 1
  error('Yen: input variables mismatch');
end	

% Check if input image is rgb and convert to a gray-level image
if ndims(input) == 3
  input = rgb2gray(input);
end 

doubleInput=double(input);

[hist,~] = imhist(uint8(input));
% calculate frequency
f = hist ./ sum(hist);
P1=cumsum(f);
P1square=cumsum(f.^2);
P2square=sum(f.^2)-P1square;

Element1=P1square.*P2square;
Element1(Element1==0)=1;
Element2=P1.*(1-P1);
Element2(Element2==0)=1;
    
crit=-log(Element1)+2*log(Element2);
[~,thresh0]=max(crit);
thresh=(thresh0-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput))); 
    
end


