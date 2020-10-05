function param = solve_cvx(param,R,g_bar)    
    range_n = range_N(param);
    range_g = range_G(param);
    [M,d] = size(param.s);
    cvx_begin quiet
    cvx_precision high
    variable z(M)
    variable x(d)
    variable g(M)
    variable n(M) integer
    minimize sum(z)
    for i = 1:M
        - z(i) <= g(i) - param.a(i) - param.lambda*n(i) <= z(i)
    end
    for i = 1:M
        param.s(i,:)*param.s(i,:)' + R^2  - 2*param.s(i,:)*x == g(i)*g_bar(i)
        range_n(i,1) <= n(i) <= range_n(i,2)
        range_g(i,1) <= g(i) <= range_g(i,2)
    end
    0 <= 2*R^2 - 2*x'*param.x_0' <= (1000*param.rho)^2
    cvx_end
    x = x';
    n = n';
    param.x = x;
    param.n = n;
    param = solve_x(param);
    param.obj = objective(param);
    param.z = z;
    param.g = g;
end