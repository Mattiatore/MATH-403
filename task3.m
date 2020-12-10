clc; clear; close all

size_tensor = 200;
X = tensor(normrnd(0,1, size_tensor, size_tensor, size_tensor));
ranks = 5:5:50;

% HOSVD
[errHOSVD, timeHOSVD] = testHOSVD(X, 0, ranks, 0, 1);

% MHOSVD
[errMHOSVD, timeMHOSVD] = testMHOSVD(X, 0, ranks, eps, 0, 1);

figure(1)
semilogy(ranks, errMHOSVD, 'k-o', 'markersize', 9)
hold on
semilogy(ranks, errHOSVD, 'r-d', 'markersize', 9)
xlabel('Rank')
ylabel('Relative error')
box on
legend({'MHOSVD','HOSVD'}, 'location', 'NE')
title("Error comparison for random tensor of MHOSVD vs HOSVD")
hold off

figure(2)
semilogy(ranks, timeMHOSVD, 'k-o', 'markersize', 9)
hold on
semilogy(ranks, timeHOSVD, 'r-d', 'markersize', 9)
xlabel('Rank')
ylabel('Time cost')
box on
legend({'MHOSVD','HOSVD'}, 'location', 'NE')
title("Time comparison for random tensor of MHOSVD vs HOSVD")
hold off