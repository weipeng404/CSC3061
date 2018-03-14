function [ Edges, Iver, Ihor ] = edgeExtraction( Iin,B1,B2 )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
Iin=double(Iin);
Iver = conv2(Iin,B1);
Ihor = conv2(Iin,B2);
Edges = sqrt(Iver.^2 + Ihor.^2);

end

