N = [25,50,100,200];

% hold on

k = [];
j = [];
for i = N
    [xb,ub] = prob2b(i);
    u = prob2a(i,xb);
    k = [k max(abs(u-ub))];
%     plot(xb,ub);

    [xc,uc] = prob2c(i);
    u = prob2a(i,xc);
    j = [j max(abs(u-uc))];
%     plot(xc,uc);
end

figure()
semilogy(N, k, 'r', N, j, 'b');
xlabel('N') 
ylabel('log(max|U(x,2) - u(x,2)|)')
legend({'finite differences','Gauss-Chebyshev-Lobatto'},'Location','northeastn')