function [Q] = ARRF(A,r,eps)
%UNTITLED 
%  
[m,n] = size(A);
omega = normrnd(0,1,[n,r]);
Y = A*omega;
j = 0;
Qold = zeros(m,0);
while (max(vecnorm(Y(:,j+1:j+r))) > eps/(10*(2/pi)^(1/2)))
    j = j+1;
    Y(:,j) = (eye(m)-Qold*Qold')*Y(:,j);
    q = Y(:,j)/vecnorm(Y(:,j));
    Qnew = [Qold q];
    omega = normrnd(0,1,[n,1]);
    Y(:,j+r) = (eye(m)-Qnew*Qnew')*A*omega;
    for i = j+1:(j+r-1)
       Y(:,i) = Y(:,i) - q*q'*Y(:,i); 
    end
    Qold = Qnew;
end
Q = Qnew;
j

