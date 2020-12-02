clear all
clc
% test
Randomized_range_finder([0,1,5;1,2,3;0,2,1],1)
function Q = Randomized_range_finder(A,L)
sz = size(A)
m = sz(1)
n = sz(2)
sigma = normrnd(0,1,n,L)
Y = A*sigma
[Q, R] = qr(Y)
Q = Q(:,1:L)
end