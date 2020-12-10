function [Q] = ARRF(A,eps)
[m,n] = size(A);
r = 10; % paper's example
omega = normrnd(0,1,[n,r]);
Y = A*omega;
j = 0;
Q = zeros(m,0);
while (max(vecnorm(Y(:,j+1:j+r))) > eps/(10*(2/pi)^(1/2)))
    j = j+1;
    Y(:,j) = (eye(m)-Q*Q')*Y(:,j);
    q = Y(:,j)/vecnorm(Y(:,j));
    Q = [Q q];
    omega = normrnd(0,1,[n,1]);
    Y(:,j+r) = (eye(m)-Q*Q')*A*omega;
    for i = j+1:(j+r-1)
       Y(:,i) = Y(:,i) - q*q'*Y(:,i); 
    end
end