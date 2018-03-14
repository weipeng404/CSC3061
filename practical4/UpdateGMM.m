function [ w, mean, sd ] = UpdateGMM( w, mean, sd, alpha, pixval )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<5 % if no pixel value is assigned to such a Gaussian
    w = (1-alpha)*w;
    mean = mean;
    sd = sd;
else
    w = (1-alpha)*w + alpha;
    mean = (1 - alpha/w)*mean + alpha/w * pixval;
    sd = sqrt((1 - alpha/w)*(sd^2) + alpha/w * (pixval-mean)^2);
end

end

