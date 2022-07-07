
% % *** plot region of stability ***
th = linspace(0,2*pi,1000);
z = exp(1i*th);

S = @(z) (1 + z/2)/(1 - z/2);

reg = zeros(1,1000);

for i = 1:1000
    reg(i) = S(z(i));
end

plot(reg)

S(1)

