r1 = 1;
r2 = 4;
nu = 1/2;

hold on
for n = 10:10:200
    dr = (r2-r1)/(n+1);
    r = (r1+dr:dr:r2-dr)';
    [r_,w] = lgwt(n,r1,r2);
    dt = 5*10^-5;
    
    D2 = zeros(n);
    for i = 1:n-1
        D2(i,i) = -2;
        D2(i,i+1) = 1;
        D2(i+1,i) = 1;
    end
    D2(n,n) = -2;
    D2 = D2/(dr^2);
        
    Dr = zeros(n);
    for i = 1:n-1
        Dr(i,i+1) = 1/(1+i*dr);
        Dr(i+1,i) = -1/(1+i*dr+dr);
    end
    Dr = Dr/(2*dr);
        
    M = nu*(D2+Dr);
    
    N = 2/dt;
    pts = 500;
    
    U = zeros(n,N);
    U(:,1) = (10*(r-1).*(4-r).^2).*exp(-r);
    U(:,2) = U(:,1) + dt*M*U(:,1);
    U(:,3) = U(:,2) + dt*M*U(:,2);
    
    U0 = (10*(r_-1).*(4-r_).^2).*exp(-r_);

    f = @(b) besselj(0,b*r1)*bessely(0,b*r2) - besselj(0,b*r2)*bessely(0,b*r1);
    
    for i = 4:N
        U(:,i) = U(:,i-1) + (dt/12)*M*(23*U(:,i-1) - 16*U(:,i-2) + 5*U(:,i-3));
    end

    sum = zeros(n,1);
    for k = 1:50
        bk0 = 1 + 1.05*(k - 1);
        bk = fzero(f, bk0);
    
        Rk_norm = sqrt((2/(pi^2*bk^2))*((besselj(0,bk*r1)^2 - besselj(0,bk*r2)^2)/(besselj(0,bk*r1)^2)));
                
        % Legendre-Gauss nodes
        Rk_ = besselj(0,bk*r_)*bessely(0,bk*r2) - besselj(0,bk*r2)*bessely(0,bk*r_);
        Rk_hat_ = Rk_/Rk_norm;
                
        % Evenly spaced nodes
        Rk = besselj(0,bk*r)*bessely(0,bk*r2) - besselj(0,bk*r2)*bessely(0,bk*r);
        Rk_hat = Rk/Rk_norm;
            
        sum = sum + Rk_hat*exp(-bk^2*nu*(2))*(w'*(r_.*Rk_hat_.*U0));
    end
    e = max(abs(sum - U(:,end)));

    scatter(n,e,'filled','b');
end
xlabel('log(n)');
ylabel('log(e(2))');
set(gca,'xscale','log');
set(gca,'yscale','log');
% legend('n = 25', 'n = 50', 'n = 100', 'n = 150');
hold off
