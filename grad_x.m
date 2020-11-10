function grad = grad_x(param)
    a = param.a;
    lambda = param.lambda;
    s = param.s;
    x = param.x;
    n = param.n;
    a_rec = param.a_rec;
    [M,d] = size(s);
    grad = zeros(1,d);
    for i = 1:length(a)
        grad = grad + 2*(norm(s(i,:) - x) - a(i) + a_rec - n(i)*lambda)*(x - s(i,:))/norm(s(i,:) - x);
    end
end