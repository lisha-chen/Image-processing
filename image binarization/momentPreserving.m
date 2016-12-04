function thresh=momentPreserving(input)

% Moment-preserving thresholding
% 
% 
% Refs:
% W. Tsai, Moment-preserving thresholding: A new approach, 
% Comput. Vision Graphics Image Process.29, 1985, 377-393. 
%
%Author:Lisha.Chen
%

if nargin < 1 || nargin > 1
  error('momentPreserving: input variables mismatch');
end	

% Check if input image is rgb and convert to a gray-level image
if ndims(input) == 3
  input = rgb2gray(input);
end 

doubleInput=double(input);

[hist,x] = imhist(uint8(input));


% calculate frequency
P = hist ./ sum(hist);

% Calculate the first four order moments
m0 = 1.0;
m1=sum(P.*x);
m2=sum(P.*x.*x);
m3=sum(P.*x.*x.*x);

Cd = m0 * m2 - m1 * m1;
C0 = (-m2 * m2 + m1 * m3) / Cd;
C1 = (m0 * -m3 + m2 * m1) / Cd;
Z0 = 0.5 * (-C1 - sqrt(C1 * C1 - 4.0 * C0));
Z1 = 0.5 * (-C1 + sqrt(C1 * C1 - 4.0 * C0));
Pd=Z1-Z0;
P0 = (Z1 - m1) / Pd;

thresh0=x(find(cumsum(P)>P0, 1, 'first' ));

thresh=(thresh0-min(min(doubleInput)))/(max(max(doubleInput))-min(min(doubleInput)));
end