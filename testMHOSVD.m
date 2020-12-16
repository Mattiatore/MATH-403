function [err, time] = testMHOSVD(F, method, rank, eps, oversampling, trials)
% F: tensor
% method: {0, 1}) -- for rank based use 0 , for tol based use 1
% rank: int -- Prescribe rank R (same for each dimension)
% eps: real -- Prescribe tolerance for tolerance method
% trials: int -- number of different runs

if (method==1)
    time = zeros(trials,length(eps));
    err = time;
    lung = length(eps);
else
    time = zeros(trials,length(rank));
    err = time;
    lung = length(rank);
end

for j = 1 : trials

    for i = 1 : lung
        
        r = rank(i);
        
        tic
        [T,U1,U2,U3] = mHOSVD(F, method, r, eps, oversampling);
        time(j, i) = toc;
        T = ttm(T,U1,1);
        T = ttm(T,U2,2);
        T = ttm(T,U3,3);
        error= F-T;
        err(j, i) = sqrt(sum(sum(sum(error.*error))) / sum(sum(sum(F.*F))));
        
    end
    
end

if trials > 1
    err = mean(err);
    time = mean(time);
end

