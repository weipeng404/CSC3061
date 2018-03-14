function Iout = myconvolution(Iin,B)

Iin=double(Iin);
B=double(B);

%Task1 Step 5
[M1, N1] = size(Iin);
[M2, N2] = size(B);

for k=1:(M1-M2+1)
    for l=1:(N1-N2+1)
        temp = 0;
        for i=k:(k+M2-1)
            for j=l:(l+N2-1)
                temp = temp + Iin(i,j) * B(i-k+1,j-l+1); 
            end
        end
        Iout(k,l) = temp;
    end
end

end
 