clear all
size_tensor = 70; % try also 50, HOSVD seems terrible, also i did not try 200 was too slow.
X = rand(size_tensor, size_tensor, size_tensor);
T1 = zeros(10,1);
T2 = zeros(10,1);
N1 = zeros(10,1);
N2 = zeros(10,1);
eps = 0.0001;
for k = 5:5:50
    X = tensor(X);
    tic
    [C,U1,U2,U3] =  mHOSVD(X,10,k,k,k,eps);
    T1(k/5) = toc;
    diff = X - ttm(C,{U1,U2,U3},[1 2 3]);
    N1(k/5) = norm(diff); 
    tic
    T = hosvd(X,eps,'ranks',[k,k,k]);
    T2(k/5)= toc;
    diff = X - ttm(T.core,{T.U{1},T.U{2},T.U{3}},[1 2 3]);
    N2(k/5) = norm(X-T); 
end
figure(1)
semilogy(5:5:50,N1)
legend("mHOSVD error")
figure(2)
semilogy(5:5:50,N2)
legend("HOSVD error")
figure(3)
plot(5:5:50,T1)
hold on
plot(5:5:50,T2)
hold off
legend("mHOSVD time","HOSVD time")
