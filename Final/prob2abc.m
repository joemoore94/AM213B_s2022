r1 = 1;
r2 = 4;
nu = 1/2;

figure(1)
hold on
for k = 1:20
    n = 10 + 10*(k-1);
    dr = (r2-r1)/(n+1);
    r_total = r1:dr:r2;
    r =  r1+dr:dr:r2-dr;

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
    rho = max(abs(eig(M)));
%     scatter(n,rho, 'filled', 'b');
%     xlabel('n')
%     ylabel('ρ(M)')

    dts = (6/11)*(1/rho);
    scatter(log(n), log(dts), 'filled', 'b')
    ylabel('log(Δt^*)')
    xlabel('log(n)')
end
hold off
