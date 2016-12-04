function output=im2binary(varargin)

[input,P,func]=parse_inputs(varargin{:});
switch func
    case 'Otsu'
        thresh=graythresh(input);
    case 'Huangs_Fuzzy'
        thresh=Huangs_Fuzzy(input);
    case 'ISODATA'
        thresh=ISODATA(input);
    case 'MaxEntropy'
        thresh=MaxEntropy(input);
    case 'meanPeak'
        thresh=meanPeak(input);
    case 'MinError'
        thresh=MinError(input);
    case 'minValley'    
        thresh=minValley(input);
    case 'momentPreserving'    
        thresh=momentPreserving(input);
    case 'P_Tile'    
        thresh=P_Tile(input,P);
    case 'Shanbhag'    
        thresh=Shanbhag(input);
    case 'Yen'    
        thresh=Yen(input);    
end

output=im2bw(uint8(input),thresh);
figure,imshow(output);
end

function [input,P,func] = parse_inputs(varargin)

input = varargin{1};
func=varargin{end};
if strcmp(func,'P_Tile')==1
    P=varargin{2};
else P=[];
end
end