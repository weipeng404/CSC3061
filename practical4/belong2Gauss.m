function [ belonging ] = belong2Gauss( distance, sd, threshold )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
belonging = distance/sd <= threshold;

end

