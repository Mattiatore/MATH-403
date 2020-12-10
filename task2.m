clc; clear; close all

n = 50;
eps = flip(logspace(-10,-2,10));
rank = round(linspace(2, n-1, 10));

F =zeros(n,n,n);
for i=1:n
    for j=1:n
        for k=1:n
            F(i,j,k) = 1/(i/10+j/10+k/10)^(1/2);
        end
    end
end
F = tensor(F);

[RerrMHOSVD, RtimeMHOSVD] = testMHOSVD(F, 0, rank, eps, 0, 1);
[RerrHOSVD, RtimeHOSVD] = testHOSVD(F, 0, rank, eps, 1);
[TerrMHOSVD, TtimeMHOSVD] = testMHOSVD(F, 1, rank, eps, 0, 1);
[TerrHOSVD, TtimeHOSVD] = testHOSVD(F, 1, rank, eps, 1);


figure(1)
semilogy(rank, RerrMHOSVD, 'k-o', 'markersize', 9)
hold on
semilogy(rank, RerrHOSVD, 'r-d', 'markersize', 9)
xlabel('Rank')
ylabel('Relative error')
box on
legend({'MHOSVD','HOSVD'}, 'location', 'NE')
title("Error comparison of MHOSVD vs HOSVD, method rank ")
hold off

figure(2)
semilogy(rank, RtimeMHOSVD, 'k-o', 'markersize', 9)
hold on
semilogy(rank, RtimeHOSVD, 'r-d', 'markersize', 9)
xlabel('Rank')
ylabel('Time cost')
box on
legend({'MHOSVD','HOSVD'}, 'location', 'NE')
title("Time comparison of MHOSVD vs HOSVD, method rank ")
hold off

figure(3)
semilogy(rank, TerrMHOSVD, 'k-o', 'markersize', 9)
hold on
semilogy(rank, TerrHOSVD, 'r-d', 'markersize', 9)
xlabel('Rank')
ylabel('Relative error')
box on
legend({'MHOSVD','HOSVD'}, 'location', 'NE')
title("Error comparison of MHOSVD vs HOSVD, method tolerance ")
hold off

figure(4)
semilogy(rank, TtimeMHOSVD, 'k-o', 'markersize', 9)
hold on
semilogy(rank, TtimeHOSVD, 'r-d', 'markersize', 9)
xlabel('Rank')
ylabel('Time cost')
box on
legend({'MHOSVD','HOSVD'}, 'location', 'NE')
title("Time comparison of MHOSVD vs HOSVD, method tolerance ")
hold off