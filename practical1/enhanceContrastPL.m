function [ Iout ] = enhanceContrastPL( Iin, gamma )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
Lut = contrast_PL_LUT(gamma);
Iout = intlut(Iin, Lut);

end

