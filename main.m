clear all
cvx_solver gurobi_2
dis = 5;
% R = 6371.2;
% M = 4;
% d = 3;
% param = realdata_simulator(R,M,d,dis)
emitter  = [3844059.71543,709661.56843,5023129.70605]/1000;
R = norm(emitter);
M = 5;
d = 3;
param = realdata_simulator2(R,M,d,dis);

emitter = param.x_e;
x_0 = param.x_0;
a = param.a;
XYZ = param.s;
x = zeros(1,d);
range_n = range_N(param);
range_g = range_G(param);
lambda = param.lambda;
[M,d] = size(XYZ);
g_bar = zeros(M,1);
for i = 1:M
    g_bar(i) = norm(param.x_0 - XYZ(i,:));
end
k = 1;
x_old = x_0;
obj_best = 9999;
while(1000*norm(x_old - x)>1e-10)
    x_old = x;
    cvx_begin quiet
    cvx_precision high
    variable z(M)
    variable x(d)
    variable g(M)
    variable n(M) integer
    minimize sum(z)
    for i = 1:M
        - z(i) <= g(i) - a(i) - lambda*n(i) <= z(i)
    end
    for i = 1:M
        XYZ(i,:)*XYZ(i,:)' + R^2  - 2*XYZ(i,:)*x == g(i)*g_bar(i)
        range_n(i,1) <= n(i) <= range_n(i,2)
        range_g(i,1) <= g(i) <= range_g(i,2)
    end
    0 <= 2*R^2 - 2*x'*x_0' <= (1000*param.rho)^2
    cvx_end
    x = x';
    n = n';
    param.x = x;
    param.n = n;
    param = solve_x(param);
    obj = objective(param);
    if obj<obj_best
        obj_best = obj;
        x_best = x;
        n_best = n;
    end
    fprintf("Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f|Dif_g:%2.4f\n",1000*norm(emitter - x_0),1000*norm(param.x_e - x),1e6*sum(z),norm(g_bar - g))
    fprintf("x:(%2.10f,%2.10f,%2.10f)\n",x(1),x(2),x(3))
    fprintf("n:(%8.0f,%8.0f,%8.0f,%8.0f,%8.0f)\n",n(1),n(2),n(3),n(4),n(5))
    g_bar = g;
    k = k + 1;
    if k >= 10
        break
    end
end
fprintf("Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f\n",1000*norm(emitter - x_0),1000*norm(param.x_e - x_best),1e6*obj_best)
% earth



