function param = solve_n(param)
[M,d] = size(param.s);
cvx_begin quiet
cvx_precision best
variable z(M)
variable a_rec
variable n(M) integer
minimize sum(z)
for i = 1:M
    - z(i) <= norm(param.s(i,:) - param.x) + param.a(i) - a_rec - param.lambda*n(i) <= z(i)
    0 <= a_rec - param.a(i) <= param.lambda
end
cvx_end
param.n = n';
param.x = param.x_0;
param.a_rec = a_rec;
