function [ Iout ] = noiseReduction( I,N )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
mask = 1/(N^2) * ones(N,N);
Iout = conv2(I,mask);

end

