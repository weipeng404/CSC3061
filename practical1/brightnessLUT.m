function [ Lut ] = brightnessLUT( c )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
for i = 1:256
    Lut(i) = i-1;
end
for i = 1:256
    if Lut(i) < -c
        Lut(i) = 0;
    else if Lut(i) > 255-c
            Lut(i) = 255;
        else
            Lut(i) = Lut(i) + c;
        end
    end
end
Lut = uint8(Lut);
end