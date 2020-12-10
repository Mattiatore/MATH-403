function [err, time] = testMHOSVD(F, method, rank, eps, oversampling, trials)

time = zeros(trials, max(length(eps),length(rank)));
err = time;

for j = 1 : trials

    for i = 1 : length(rank)
        
        r = rank(i);
        
        tic
        Tmod = mHOSVD(F, method, r, eps, oversampling);
        time(j, i) = toc;
        err(j, i) = norm(F - full(Tmod)) / norm(F);
        
    end
    
end

if trials > 1
    err = mean(err);
    time = mean(time);
end

