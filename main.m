clear all
cvx_solver gurobi_2
dis = 1;
% R = 6371.2;
% M = 4;
% d = 3;
% param = realdata_simulator(R,M,d,dis)
R = 6.364923148106367e+03;
M = 5;
d = 3;
param = realdata_simulator2(R,M,d,dis);

[M,d] = size(param.s);
g_bar = zeros(M,1);
for i = 1:M
    g_bar(i) = norm(param.x_0 - param.s(i,:));
end
k = 1;
x_old = param.x_0;
obj_best = 9999;
while(1000*norm(x_old - param.x)>1e-10)
    x_old = param.x;
    param = solve_cvx(param,R,g_bar);
    if param.obj<obj_best
        obj_best = param.obj;
        x_best = param.x;
        n_best = param.n;
    end
    fprintf("Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f|Dif_g:%2.4f\n",1000*norm(param.x_e - param.x_0),1000*norm(param.x_e - param.x),1e6*sum(param.z),norm(g_bar - param.g))
    fprintf("x:(%2.10f,%2.10f,%2.10f)\n",param.x(1),param.x(2),param.x(3))
    fprintf("n:(%8.0f,%8.0f,%8.0f,%8.0f,%8.0f)\n",param.n(1),param.n(2),param.n(3),param.n(4),param.n(5))
    g_bar = param.g;
    k = k + 1;
    if k >= 10
        break
    end
end
fprintf("Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f\n",1000*norm(param.x_e - param.x_0),1000*norm(param.x_e - x_best),1e6*obj_best)
% earth



