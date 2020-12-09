F =zeros(50,50,50);
for i=1:50
    for j=1:50
        for k=1:50
            F(i,j,k) = 1/(i/10+j/10+k/10)^(1/2);
        end
    end
end
F = tensor(F);
eps = 0.0001;
k=5;
[C,U1,U2,U3] =  mHOSVD(F,10,k,k,k,eps);
diff = F - ttm(C,{U1,U2,U3},[1 2 3]);
norm(diff)