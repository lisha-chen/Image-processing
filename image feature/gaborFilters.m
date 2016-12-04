function gaborArray = gaborFilters(u,v,m,n)

% GABORFILTERBANK generates a custum Gabor filter bank. 
% It creates a u by v cell array, whose elements are m by n matrices; 
% each matrix being a 2-D Gabor filter.
%
%   Details can be found in:   
%   M. Haghighat, S. Zonouz, M. Abdel-Mottaleb, "CloudID: Trustworthy 
%   cloud-based and cross-enterprise biometric identification," 
%   Expert Systems with Applications, vol. 42, no. 21, pp. 7905-7916, 2015.
% 
% (C)	Mohammad Haghighat, University of Miami
%       haghighat@ieee.org
%       PLEASE CITE THE ABOVE PAPER IF YOU USE THIS CODE.
% 
%% 
% Input:
%   u:No.of scales (usually set to 5) 
%   v:No.of orientations (usually set to 8)
%   m:No.of rows in a 2-D Gabor filter (an odd integer number, usually set to 39)
%   n:No.of columns in a 2-D Gabor filter (an odd integer number, usually set to 39)
% 
% Output:
%   gaborArray: A u by v array, element of which are m by n 
%               matries; each matrix being a 2-D Gabor filter   
% 
%% Usage:
% u=5; v=8;
% gaborArray = gaborFilters(u,v,39,39);
%  [m,n]=size(input); % input image
%  input=double(input);
% for i=1:u
%      for j=1:v
%          i1 = i+ f;
%          j1 = j+ f;
%          W{i,j}=conv2(input,gaborArray{i,j},'same');         
%      end
%  end

%%
if (nargin ~= 4)    % Check correct number of arguments
    error('There must be four input arguments (Number of scales and orientations and the 2-D size of the filter)!')
end


%% Create Gabor filters
% Create u*v gabor filters each being an m by n matrix

gaborArray = cell(u,v);
fmax = 0.1;
gama = sqrt(2)/5;
eta = sqrt(2)/5;

for i = 1:u
    
    fu = fmax/((sqrt(2))^(i-1));%center frequency
    alpha = fu/gama;
    beta = fu/eta;
    
    for j = 1:v
        tetav = ((j-1)/v)*pi;
        
        [x,y]=meshgrid(1:m,1:n);
                xprime = (x-((m+1)/2)).*cos(tetav)+(y-((n+1)/2)).*sin(tetav);
                yprime = -(x-((m+1)/2)).*sin(tetav)+(y-((n+1)/2)).*cos(tetav);
                gFilter= (fu^2/(pi*gama*eta)).*...
                    exp(-((alpha^2)*(xprime.^2)+(beta^2)*(yprime.^2))).*...
                    exp(1i*2*pi*fu.*xprime);
            
        gaborArray{i,j} = gFilter;
        
    end
end


%% Show Gabor filters (Please comment this section if not needed!)

%Show magnitudes of Gabor filters:
figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
for i = 1:u
    for j = 1:v        
        subplot(u,v,(i-1)*v+j);        
        imshow(abs(gaborArray{i,j}),[]);
    end
end

% Show real parts of Gabor filters:
figure('NumberTitle','Off','Name','Real parts of Gabor filters');
for i = 1:u
    for j = 1:v        
        subplot(u,v,(i-1)*v+j);        
        imshow(real(gaborArray{i,j}),[]);
    end
end