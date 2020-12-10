n=99
F =zeros(n,n,n);
for i=1:n
    for j=1:n
        for k=1:n
            F(i,j,k) = 1/(i/10+j/10+k/10)^(1/2);
        end
    end
end
F = tensor(F);
[errMHOSVD, timeMHOSVD] = testMHOSVD(F, 1, 0, 1e-5, 0, 1)
