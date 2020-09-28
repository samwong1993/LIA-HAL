function param = realdata_simulator(R,M,d,dis)
lambda  = 0.19/1000;
emitter = randn(1,d);
emitter = R*emitter / norm(emitter);
x_0 = emitter + dis / 1000 * randn(1,d);
x_0 = R*x_0 / norm(x_0);
rho = 1.5*norm(emitter - x_0);
mid = 21000 * emitter / norm(emitter);
XYZ = zeros(M,d);
for i = 1:M
    XYZ(i,:) = mid + 1000 * randn(1,d);
end
for i = 1:M
    n(i) = floor(norm(emitter - XYZ(i,:))/lambda);
end
for i = 1:M
    a(i) = norm(emitter - XYZ(i,:)) - n(i)*lambda;
end
param.x_e = emitter;
param.a = a;
param.s = XYZ;
param.lambda = lambda;
param.x_0 = x_0;
param.n_e = n;
param.x = emitter;
param.n = n;
param.rho = rho;
obj = objective(param);
end