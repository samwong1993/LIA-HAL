function obj = objective(param) 
    a = param.a;
    a_rec = param.a_rec;
    lambda = param.lambda;
    s = param.s;
    x = param.x;
    n = param.n;
    norm_all = [];
    for i = 1:length(a)
        norm_all = [norm_all,norm(s(i,:) - x)];
    end
    obj = sum((-a + a_rec + n*lambda - norm_all).^2);
end