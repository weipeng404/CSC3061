function [ Iout ] = enhanceContrastLS( Iin, m, c )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
Lut = contrast_LS_LUT(m,c);
Iout = intlut(Iin,Lut);

end

