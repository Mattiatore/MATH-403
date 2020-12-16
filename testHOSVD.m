function [err, time] = testHOSVD(F, method, rank, eps, trials)
% F: tensor
% method: {0, 1}) -- for rank based use 0 , for tol based use 1
% rank: int -- Prescribe rank R (same for each dimension)
% eps: real -- Prescribe tolerance for tolerance method
% trials: int -- number of different runs

if (method==1)
    time = zeros(trials, length(eps));
    err = time;
    lung = length(eps);
else
    time = zeros(trials, length(rank));
    err = time;
    lung = length(rank);
end

for j = 1 : trials

    for i = 1 : lung
        
        tic
        if (method==0)
            [T,U1,U2,U3] = hosvd(F, method, rank(i) *ones(3), 0);
        else
            [T,U1,U2,U3] = hosvd(F, method, 0, eps(i));
        end
        time(j, i) = toc;
        T = ttm(T,U1,1);
        T = ttm(T,U2,2);
        T = ttm(T,U3,3);
        error = T-F;
        err(j, i) =sqrt(sum(sum(sum(error.*error))) / sum(sum(sum(F.*F))));
        fprintf('calculating  %i rank approximation \n',5*i)
    end
    
end

if trials > 1
    err = mean(err);
    time = mean(time);
end
