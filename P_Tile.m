function thresh=P_Tile(input,P)

% P_Tile method for thresholding
%
%
% Refs:
% W. Doyle, Operation useful for similarity-invariant pattern recognition, 
% J. Assoc. Comput. Mach. 9,1962, 259-267. 
% 
%Author:Lisha.Chen
%

if nargin < 1 || nargin > 2
  error('P_Tile: input variables mismatch');
end	

% Check if input image is rgb and convert to a gray-level image
if ndims(input) == 3
  input = rgb2gray(input);
end 

doubleInput=double(input);
[m,n]=size(doubleInput);
num=m*n;
sortInput=sort(doubleInput(:),'descend');
index=floor(num*P);
thresh0=(sortInput(index));
thresh=(thresh0-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput)));
end