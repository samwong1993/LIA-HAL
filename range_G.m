function range = range_G(param)
    lambda = param.lambda;
    n = param.n;
    s = param.s;
    a = param.a;
    x_0 = param.x_0;
    rho = param.rho;
    range_n = range_N(param);
    for i = 1:length(a)
        range(i,1) = a(i) + range_n(i,1)*lambda;
        range(i,2) = a(i) + range_n(i,2)*lambda;
    end
end