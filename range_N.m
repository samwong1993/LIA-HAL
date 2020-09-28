function range = range_N(param)
    lambda = param.lambda;
    n = param.n;
    s = param.s;
    a = param.a;
    x_0 = param.x_0;
    rho = param.rho;
    for i = 1:length(a)
        range(i,1) = ceil(((norm(x_0 - s(i,:)) - rho) - a(i)) / lambda);
        range(i,2) = floor(((norm(x_0 - s(i,:)) + rho) - a(i)) / lambda);
    end
end