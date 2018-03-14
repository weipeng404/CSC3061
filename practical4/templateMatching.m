function [ BB ] = templateMatching( I, template )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
I = rgb2gray(I);
template = rgb2gray(template);
I = double(I);
template = double(template);
[height, width] = size(template);

correlation = filter2(template, I);
maxVal = max(max(correlation));
[y, x] = find(correlation == maxVal);

xmin = x-width/2;
ymin = y-height/2;
BB = [xmin ymin width height];

end

