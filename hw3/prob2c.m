function [x,u] = prob2c(N)
    N = N + 1;
    [x,D1,D2] = get_GCL_points_and_D_matrices(-1,1,N);
    dt = 10^-4;
    n = 2/dt;
    u = 3 + x + 5*(1 - x.^2).^2;
    
    D2(1,1:N+1) = 0;
    D2(N+1,1:N+1) = 0;
    
    A = eye(N+1) - (dt/2)*D2;
    B = eye(N+1) + (dt/2)*D2;
    
    for i = 1:n
        u = A\(B*u);
    end
end

