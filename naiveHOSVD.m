function C = naiveHOSVD(X, method, ranks, eps)
% X: tensor
% method: {0, 1}) -- for rank based use 0 , for tol based use 1
% rank: int -- Prescribe rank R (same for each dimension)
% eps: real -- Prescribe tolerance for tolerance method

if (method==0)
    [U1, ~, ~] = svd(double(tenmat(X, 1)), 'econ');
    U1 = U1(:, 1:ranks(1));
    
    [U2, ~, ~] = svd(double(tenmat(X, 2)), 'econ');
    U2 = U2(:, 1:ranks(2));
    
    [U3, ~, ~] = svd(double(tenmat(X, 3)), 'econ');
    U3 = U3(:, 1:ranks(3));

    C = ttm(X,{U1',U2',U3'},[1 2 3]);
    C = ttensor(C, {U1,U2,U3});
else
    U = cell(3,1);

    for i = 1 : 3
        Xi = double(tenmat(X, i));   
        [U{i}, S, ~] = svd(Xi, 'econ');

        % Cut off for approximate desired tolerance
        singVal = cumsum((diag(S)).^2, 'reverse');
        cutid = find(singVal > eps^2 * norm(X)^2 / 3, 1, 'last');
        U{i} = U{i}(:, 1:cutid);
    end

    C = ttm(X,{U{1}',U{2}',U{3}'},[1 2 3]);
    C = ttensor(C, {U{1},U{2},U{3}});

end

end