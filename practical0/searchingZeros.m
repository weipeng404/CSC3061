function [ num ] = searchingZeros( input_array )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(input_array);
num = 0;
for i = 1:m
    for j = 1:n
        if input_array(i,j) == 0
        num = num + 1;
        end
    end
end
end

