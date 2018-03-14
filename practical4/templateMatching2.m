function [BBs] = templateMatching2(I,template,N)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
BBs = [];

I = rgb2gray(I);
template = rgb2gray(template);
I = double(I);
template = double(template);
[height, width] = size(template);

correlation = filter2(template, I);
mesh(correlation);

[sortedValues, sortIndex] = sort(correlation(:), 'descend');

[y, x] = ind2sub(size(correlation), sortIndex(1:N));

xmin = x-width/2;
ymin = y-height/2;

for n=1:N
    BB = [xmin(n) ymin(n) width height];
    BBs = [BBs; BB];
end

end

