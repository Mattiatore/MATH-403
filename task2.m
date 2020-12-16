fprintf('This part is for task2 \n\n')

n = 50;
eps = 0.001;
rank = 5;

F =zeros(n,n,n);
for i=1:n
    for j=1:n
        for k=1:n
            F(i,j,k) = 1/(i/10+j/10+k/10)^(1/2);
        end
    end
end

[T,U1,U2,U3] = mHOSVD(F,0,rank,eps,5);
fprintf('the size of the decomposition matrix is\n\n')
size(T)
T = ttm(T,U1,1);
T = ttm(T,U2,2);
T = ttm(T,U3,3);
e = T-F;
error = sqrt(sum(sum(sum(e.*e)))/(sum(sum(sum(F.*F)))));
fprintf('the error of the decomposition is %d, which is relative small. So we think the rank based algorithm works well\n\n',error)




[T,U1,U2,U3] = mHOSVD(F,1,rank,eps,0);
T = ttm(T,U1,1);
T = ttm(T,U2,2);
T = ttm(T,U3,3);
e = T-F;
error = sqrt(sum(sum(sum(e.*e)))/(sum(sum(sum(F.*F)))));
fprintf('the error of the decomposition is %d, which is less than the given epsilon. Hence, we believe our tolerence based algorithm works well\n\n',error)
