function thresh=Shanbhag(input)

% Shanbhag thresholding
% 
% 
% Refs:
% Shanbhag, Abhijit G. (1994), 
% Utilization of information measure as a means of image thresholding, 
% Graph. Models Image Process. 
% (Academic Press, Inc.) 56 (5): 
% 414--419, ISSN 1049-9652, DOI 10.1006/cgip.1994.1037
%
%Author:Lisha.Chen
%

if nargin < 1 || nargin > 1
  error('Shanbhag: input variables mismatch');
end	

% Check if input image is rgb and convert to a gray-level image
if ndims(input) == 3
  input = rgb2gray(input);
end 

doubleInput=double(input);
[m,n]=size(doubleInput);
num=m*n;

[hist,x] = imhist(uint8(input));
% calculate frequency
f = hist ./ sum(hist);

P1=cumsum(f);
P2=1-P1;

minGrayValue=x(find(hist>0, 1, 'first' ));
maxGrayValue=x(find(hist>0, 1, 'last' ));
minDifEntropy=1e10;

for i=minGrayValue:maxGrayValue
termBack=0.5/P1(i+1);
entropyBackElement=(hist(2:end)./num).*log(1-termBack*P1(1:end-1));
entropyBack=-sum(entropyBackElement(1:i));
entropyBack=entropyBack*termBack;

termFore=0.5/P2(i+1);
entropyForeElement=(hist./num).*log(1-termFore*P2);
entropyFore=-sum(entropyForeElement((i+2):end));
entropyFore=entropyFore*termFore;

difEntropy=abs(entropyBack-entropyFore);

if difEntropy<minDifEntropy
    minDifEntropy=difEntropy;
    thresh0=i;
end
end
thresh=(thresh0-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput)));
end





