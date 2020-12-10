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
        if (method==1)
            T = hosvd(F, eps(i), 'verbosity', 0, 'sequential', false);
        else
            T = hosvd(F, 1, 'ranks', rank(i) * ones(1, 3), 'verbosity', 0, 'sequential', false);
        end
        time(j, i) = toc;
        err(j, i) = norm(full(T) - F) / norm(F);
        
    end
    
end

if trials > 1
    err = mean(err);
    time = mean(time);
end
