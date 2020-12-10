function [err, time] = testMHOSVD(F, method, rank, eps, oversampling, trials)

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
        T = mHOSVD(F, method, r, eps, oversampling);
        time(j, i) = toc;
        err(j, i) = norm(F - full(T)) / norm(F);
        
    end
    
end

if trials > 1
    err = mean(err);
    time = mean(time);
end

