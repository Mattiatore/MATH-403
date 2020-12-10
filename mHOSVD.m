function [C] = mHOSVD(Y, method, rank, eps, oversampling)
% Y: tensor
% method: {0, 1}) -- for rank based use 0, for tol based use 1
% rank: int -- Prescribe rank R (same for each dimension)
% eps: real -- Prescribe tolerance for tolerance method
% oversampling: int -- oversample for range method (R + oversampling)

if (method==1)
    X = double(tenmat(Y,1));
    U1_tilda = ARRF(X,eps * norm(Y)/5);
    X = double(tenmat(Y,2));
    U2_tilda = ARRF(X,eps * norm(Y)/5);
    X = double(tenmat(Y,3));
    U3_tilda = ARRF(X,eps * norm(Y)/5);
else
    X = double(tenmat(Y,1));
    U1_tilda = RRF(X, rank + oversampling);
    X = double(tenmat(Y,2));
    U2_tilda = RRF(X, rank + oversampling);
    X = double(tenmat(Y,3));
    U3_tilda = RRF(X, rank + oversampling);
end

C_tilda = ttm(Y,{U1_tilda',U2_tilda',U3_tilda'},[1 2 3]);

if oversampling > 0
    C = hosvd(C_tilda, 1, 'ranks', rank * ones(1, 3), 'sequential', false, 'verbosity', 0);
    U1_tilda = U1_tilda * C.U{1};
    U2_tilda = U2_tilda * C.U{2};
    U3_tilda = U3_tilda * C.U{3};
    C = ttensor(C.core, {U1_tilda,U2_tilda,U3_tilda});
else
    C = ttensor(C_tilda, {U1_tilda,U2_tilda,U3_tilda});
end

return