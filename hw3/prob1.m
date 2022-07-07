N = [50,100,500];

hold on
for i = 1:3
    [x,u] = bvp(N(i));
    plot(x,u,'LineWidth', 1.5);
end
legend({'','N = 50','','N = 100','','N = 500'});
ylabel('u(x)');
xlabel('x');


function [x,u] = bvp(N)
    x = 2*(0:N-1)'/(N-1) - 1;
    dx = 2/(N-1);
    
    a = @(x) 2 - x^2;
    ap = @(x) -2*x;
    b = @(x) sin(pi*x);
    
    % for D^2
    D = zeros(N,N);
    D(1,1) = -(3*dx)/2;
    D(1,2) = 2*dx;
    D(1,3) = -dx/2;
    for i = 2:N-1
        D(i,i+1) = -a(x(i))/(dx^2) - ap(x(i))/(2*dx);
        D(i,i) = 2*a(x(i))/(dx^2) + b(x(i));
        D(i,i-1) = -a(x(i))/(dx^2) + ap(x(i))/(2*dx);
    end
    D(N,N) = 2*a(x(N))/(dx^2) + b(x(N));
    D(N,N-1) = -a(x(N))/(dx^2) + ap(x(N))/(2*dx);
                
    % for f(x)
    f = exp(-x);
    f(1,1) = 0;
    f(N,1) = f(N,1) + 2/(dx^2);
    
    u = D\f;
    plot(x,u)
end




