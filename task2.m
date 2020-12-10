F =zeros(50,50,50);
for i=1:50
    for j=1:50
        for k=1:50
            F(i,j,k) = 1/(i/10+j/10+k/10)^(1/2);
        end
    end
end
F = tensor(F);
[errMHOSVD, timeMHOSVD] = testMHOSVD(F, 1, 0, 1e-5, 0, 1)
