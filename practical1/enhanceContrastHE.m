function [ Iout ] = enhanceContrastHE( Iin )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
Lut = contrast_HE_LUT(Iin);
Iout = intlut(Iin, Lut);

end