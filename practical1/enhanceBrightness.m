function Iout = enhanceBrightness(Iin,c)

Lut = brightnessLUT(c);
Iout = intlut(Iin,Lut);

end