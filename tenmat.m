%n#mode matricization
function Xn = tenmat(X, n)
 N = ndims(X);
 sz = size(X);
 m = setdiff(1:N, n);
 X = permute(X,[n m]);
 Xn = reshape(X, sz(n), prod(sz(m)));
end

