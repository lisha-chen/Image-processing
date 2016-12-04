function LOG_scaled=WLD(image)

%  WLD returns the local texture pattern of an image.
% Version 0.0.1

% WLD: Weber Local Descriptor
%
% Refs:
% Jie Chen, WLD: A Robust Local Image Descriptor,
% IEEE TRANSACTIONS ON PATTERN ANALYSIS AND MACHINE INTELLIGENCE, 
% VOL. 32, NO. 9, SEPTEMBER 2010
%
%% Input: 
% image: input image
%%

d_image=double(image);

% Determine the dimensions of the input image.
[ysize, xsize] = size(image);

% Block size, each WLD code is computed within a block of size bsizey*bsizex
bsizey=3;
bsizex=3;

BELTA=1; % to avoid that center pixture is equal to zero
ALPHA=2; % like a lens to magnify or shrink the difference between neighbors
EPSILON=0.0000001;
PI=3.141592653589;
numNeighbors=8;  % using 3*3 patch for example

% Minimum allowed size for the input image depends
% on the radius of the used LBP operator.

if(xsize < bsizex || ysize < bsizey)
  error('Too small input image. Should be at least (2*radius+1) x (2*radius+1)');
end

% filter
%    1  2  3  4   5  6  7  8  9
 f00=[1, 1, 1; 1, -8, 1; 1, 1, 1];
%f00=[0, 1, 0; 1, -4, 1; 0, 1, 0];
%f00=[1, 1, 1,1,1; 1,0,0,0,1;1, 0,-16,0, 1; 1, 0,0,0, 1;1, 1, 1,1,1];
%f00=[1, 1, 1,1,1; 1,1,1,1,1;1, 1,-24,1, 1; 1, 1,1,1, 1;1, 1, 1,1,1];
%f00=[1, 1, 1,1,1,1,1; 1,0,0,0,0,0,1;1,0,0,0,0,0,1;1, 0,0,-24,0,0, 1; ...
%1,0,0,0,0,0,1;1,0,0,0,0,0,1;1, 1, 1,1,1,1,1];
%f00=[1, 1, 1,1,1,1,1,1,1; 1, 1, 1,1,1,1,1,1,1;1, 1, 1,1,1,1,1,1,1; ... 
%1, 1, 1,0,0,0,1,1,1;1, 1, 1,0,-72,0,1,1,1;1, 1, 1,0,0,0,1,1,1; ... 
% 1, 1, 1,1,1,1,1,1,1;1, 1, 1,1,1,1,1,1,1;1, 1, 1,1,1,1,1,1,1;];

% Calculate dx and dy;
dx = xsize - bsizex;
dy = ysize - bsizey;

% two matriies 
% Initialize the result matrix with zeros.
d_differential_excitation = zeros(dy+1,dx+1);
d_gradient_orientation    = zeros(dy+1,dx+1);

%% an alternative speed-up  WLD computation for the component of differential_excitation,
%% Thanks for Amir Kolaman (www.ee.bgu.ac.il/~kolaman)
LOG_scaled0=conv2(d_image,f00,'same'); %convolve with f00
figure;imshow(uint8(LOG_scaled0)); title('LOG');
LOG_scaled=255*(LOG_scaled0-min(min(LOG_scaled0)))/(max(max(LOG_scaled0))-min(min(LOG_scaled0)));
figure;imshow(uint8(LOG_scaled)); title('LOG scaled');
LOG_scaled2=atan(ALPHA*LOG_scaled0./(d_image+BELTA)); 
LOG_scaled2=255*(LOG_scaled2-min(min(LOG_scaled2)))/(max(max(LOG_scaled2))-min(min(LOG_scaled2)));
figure;imshow(uint8(LOG_scaled2)); title('LOG scaled with atan');