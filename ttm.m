%n#mode multiplication
function Y = ttm(X, A, n)

 Y = tenmat(X, n);
 Y = A * Y;
 sz = size(X);
 sz2 = [size(A,1), sz(1:(n-1)), sz((n+1):end)];
 Y = reshape(Y, sz2);
 perm = [2:n, 1, (n+1):length(sz)];
 Y = permute(Y, perm);
end