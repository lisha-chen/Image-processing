function output=tchebichef(a)

% tchebichef returns the tchebichef moment of an image patch.
%
% Refs:
% R. Mukundan, Image Analysis by Tchebichef Moments,
% IEEE TRANSACTIONS ON IMAGE PROCESSING, 
% VOL. 10, NO. 9, SEPTEMBER 2001, 
%
% Author: Lisha.Chen
%% Input: 
% a: image patch

%% Usage
%  f=5; % image patch size
%  [m,n]=size(input); % input image
%  input2 = padarray(input,[f f],'symmetric');
%  input2=double(input2);
% for i=1:m
%      for j=1:n
%          i1 = i+ f;
%          j1 = j+ f;
%          W(i,j,:,:)=tchebichef(input2(i1-f:i1+f , j1-f:j1+f));             
%      end
%  end
%%
[m,n]=size(a);
N=min(m,n);
pmax=N-1;
t=zeros(N,N);
for x=1:N
    t(x,1)=1/sqrt(N);
    t(x,2)=(2*x-N-1)*sqrt(3/(N*(N^2-1)));
    for p=2:pmax
        alpha1=sqrt((4*p^2-1)/(N^2-p^2))/p;
        alpha2=(1-p)*sqrt((2*p+1)*(N^2-(p-1)^2)/((2*p-3)*(N^2-p^2)))/p;
        t(x,p+1)=alpha1*(2*x-N-1)*t(x,p)+alpha2*t(x,p-1);
    end
end

T=t'*a*t;
output=T;