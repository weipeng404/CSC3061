function [ h ] = myHistogram( I )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
H = histogram(I, 'BinLimits', [0,256], 'BinWidth',1);
h = H.Values;
end

