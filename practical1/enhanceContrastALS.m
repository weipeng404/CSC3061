function [ Iout, Lut ] = enhanceContrastALS( Iin )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
Iin_Hist = histogram(Iin, 'BinLimits', [0,256], 'BinWidth',1);
Iin_Hist_V = Iin_Hist.Values;
I = find(Iin_Hist_V);
sz = I(size(I));
i1 = sz(1);
i2 = sz(2);

m = 255/(i2-i1);
c = -m * i1;

Lut = contrast_LS_LUT(m,c);
Lut = uint8(Lut);

Iout = intlut(Iin, Lut);

end

