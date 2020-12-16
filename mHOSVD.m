function [C_tilda,U1_tilda,U2_tilda,U3_tilda] = mHOSVD(Y, method, rank, eps, oversampling)
% Y: tensor
% method: {0, 1}) -- for rank based use 0, for tol based use 1
% rank: int -- Prescribe rank R (same for each dimension)
% eps: real -- Prescribe tolerance for tolerance method
% oversampling: int -- oversample for range method (R + oversampling)

norm = sqrt(sum(sum(sum(Y.*Y))));
if (method==1)
    X = double(tenmat(Y,1));
    U1_tilda = ARRF(X,eps * norm/5);
    X = double(tenmat(Y,2));
    U2_tilda = ARRF(X,eps * norm/5);
    X = double(tenmat(Y,3));
    U3_tilda = ARRF(X,eps * norm/5);
else
    X = double(tenmat(Y,1));
    U1_tilda = RRF(X, rank + oversampling);
    X = double(tenmat(Y,2));
    U2_tilda = RRF(X, rank + oversampling);
    X = double(tenmat(Y,3));
    U3_tilda = RRF(X, rank + oversampling);
end


Y = ttm(Y,U1_tilda',1);
Y = ttm(Y,U2_tilda',2);
C_tilda = ttm(Y,U3_tilda',3);


if oversampling > 0
    [C_tilda,U1,U2,U3] = hosvd(C_tilda, 0, rank*ones(3) ,0.01);
    U1_tilda = U1_tilda * U1;
    U2_tilda = U2_tilda * U2;
    U3_tilda = U3_tilda * U3;
else
end

return