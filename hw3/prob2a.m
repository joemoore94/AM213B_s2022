function u = prob2a(k, x)
    N = 10; 
    t = 2; 
    k = k + 2;
    sum = zeros(k,1);
    
    for n = 1:N
        f = @(x) 5*(1-x.^2).^2.*sin(n*(pi/2).*(x+1));
        y = integral(f,-1,1)*sin(n*(pi/2)*(x+1)).*exp(-((n*pi/2)^2)*t);
        sum = sum + y;
    end
    
    u = sum + 3 + x;
end




