function param = solve_cvx(param,R,g_bar)    
    range_n = range_N(param);
    range_g = range_G(param);
    [M,d] = size(param.s);
    cvx_begin quiet
    cvx_precision best
    variable z(M)
%     variable z2(M)
    variable x(d)
    variable g(M)
    variable a_rec
    variable n(M) integer
    minimize sum(z)% + 0.02*sum(z2)
    for i = 1:M
        - z(i) <= g(i) - param.a(i) + a_rec - param.lambda*n(i) <= z(i)
        0<= param.a(i) - a_rec <= param.lambda
%         - 1e-7 <= g(i) - g_ini(i) <= 1e-7
%         - z2(i) <= g(i) - g_bar(i) <= z2(i)
    end
    for i = 1:M
        param.s(i,:)*param.s(i,:)' + R^2  - 2*param.s(i,:)*x == g(i)*g_bar(i)
        range_n(i,1) <= n(i) <= range_n(i,2)
        range_g(i,1) <= g(i) <= range_g(i,2)
    end
    0 <= 2*R^2 - 2*x'*param.x_0' <= (param.rho)^2
    cvx_end
    x = x';
    n = n';
    param.x = x;
    param.n = n;
    param.a_rec = a_rec;
    param = solve_x(param);
    param.obj = objective(param);
    param.z = z;
    param.g = g;
end