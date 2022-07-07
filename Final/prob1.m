r1 = 1;
r2 = 4;
nu = 1/2;
N = 150;

[r,w] = lgwt(N,r1,r2);
U0 = (10*(r-1).*(4-r).^2).*exp(-r);

figure(1)
plot(r,U0)

f = @(b) besselj(0,b*r1)*bessely(0,b*r2) - besselj(0,b*r2)*bessely(0,b*r1);

figure(2)
hold on
for t = [0,0.5,1,2]
    sum = zeros(N,1);
    for k = 1:50
        bk0 = 1 + 1.05*(k - 1);
        bk = fzero(f, bk0);
    
        Rk = besselj(0,bk*r)*bessely(0,bk*r2) - besselj(0,bk*r2)*bessely(0,bk*r);
        Rk_norm = (2/(pi^2*bk^2))*((besselj(0,bk*r1)^2 - besselj(0,bk*r2)^2)/(besselj(0,bk*r1)^2));
        Rk_norm = sqrt(Rk_norm);
        Rk_hat = Rk/Rk_norm;
    
        sum = sum + Rk_hat*exp(-bk^2*nu*t)*(w'*(r.*Rk_hat.*U0));
    end
    plot(r, sum)
end
legend('t = 0','t = 0.5','t = 1','t = 2')