function [ matrix ] = addOneWithFors( matrix )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(matrix);
for i = 1:m
    for j=1:n
        matrix(i,j) = matrix(i,j) + 1;
    end
end
end

