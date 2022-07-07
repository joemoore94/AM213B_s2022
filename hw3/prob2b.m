function [x,u] = prob2b(N)
    dx = 2/(N-1);
    x = (2-dx-dx)*(0:N-1)'/(N-1) - 1 + dx;
    dt = 10^-4;
    n = 2/dt;
    u = 3 + x + 5*(1 - x.^2).^2;
    
    % for D^2
    D = zeros(N,N);
    D(1,1) = -2;
    D(1,2) = 1;
    for i = 2:N-1
        D(i,i+1) = 1;
        D(i,i) = -2;
        D(i,i-1) = 1;
    end
    D(N,N) = -2;
    D(N,N-1) = 1;
    D = D/(dx^2);
    
    A = eye(N) - (dt/2)*D;
    B = eye(N) + (dt/2)*D;
    
    for i = 1:n
        b = B*u;
        b(1) = b(1) + (2*dt)/(dx^2);
        b(N) = b(N) + (4*dt)/(dx^2);
        u = A\b;
    end
    
    x = [-1;x;1];
    u = [2;u;4];
end