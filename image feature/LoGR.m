function R0=LoGR(inputImage,sigma,fsize)

%  LoGR returns the LoG of an image.
% LoG: laplacian of gaussian
%
% Author: Lisha.Chen
%% Input: 
% inputImage: input image
% sigma: parameter sigma in gaussian
% fsize: the size of the LoG filter
%%

if ndims(inputImage) == 3 
  inputImage = rgb2gray(inputImage);
end 
inputImage=double(inputImage);
if isempty(fsize)
        fsize = ceil(sigma*3) * 2 + 1;  % choose an odd fsize > 6*sigma;
end
        op = fspecial('log',fsize,sigma);
    op = op - sum(op(:))/numel(op); % make the op to sum to zero
    R0 = conv2(inputImage,op,'same');
    R=255*(R0-min(R0(:)))./(max(R0(:))-min(R0(:)));
    figure,imshow(uint8(inputImage));title('input Image');
    figure,imshow(uint8(R));title('response visualization');
end