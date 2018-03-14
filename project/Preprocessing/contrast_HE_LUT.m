function [ Lut ] = contrast_HE_LUT( Iin )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
for i = 1:256
    Lut(i) = i-1;
end
H = histogram(Iin, 'BinLimits', [0,256], 'BinWidth',1);
HV = H.Values;
CH = cumsum(HV);
for i = 1:256
    out = max(0, round(CH(i) / (256*256/256) - 1));
    if out > 255
        Lut(i) = 255;
    else
        Lut(i) = out;
    end
end
Lut = uint8(Lut);

end

