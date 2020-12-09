function [C,U1,U2,U3] = mHOSVD1(X,k1,k2,k3)
%UNTITLED 
%   
Y = tenmat(X,1).data;
U1_tilda = RRF(Y,k1);
Y = tenmat(X,2).data;
U2_tilda = RRF(Y,k2);
Y = tenmat(X,3).data;
U3_tilda = RRF(Y,k3);

C_tilda = ttm(X,{U1_tilda',U2_tilda',U3_tilda'},[1 2 3]);

%T = hosvd(C_tilda,eps,'ranks',[k1,k2,k3]);
%C = T.core;
%U1 = U1_tilda * T.U{1};
%U2 = U2_tilda * T.U{2};
%U3 = U3_tilda * T.U{3};
C = C_tilda;
U1 = U1_tilda ;
U2 = U2_tilda ;
U3 = U3_tilda ;
end