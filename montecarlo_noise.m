clear all
cvx_solver gurobi_2
R = 6.364923148106367e+06;
for iter = 1:100
    load noisedata
    a_e = param.a;
    param.rho = 1.5*norm(param.x_0 - param.x_e);
    [M,d] = size(param.s);
    param.a = param.a + 1e-5*randn(1,M);
    obj_old = objective(param); 
    g_bar = zeros(M,1);
    for i = 1:M
        g_bar(i) = norm(param.x_0 - param.s(i,:));
    end
    k = 1;
    x_old = param.x_0;
    obj_best = 9999;
	param.x = zeros(1,d);
    param.n = zeros(1,M);
    while(norm(x_old - param.x)>1e-12)
        x_old = param.x;
        param = solve_cvx(param,R,g_bar);
        if param.obj<obj_best
            obj_best = param.obj;
            x_best = param.x;
            n_best = param.n;
        end
        fprintf("Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f|Dif_g:%2.4f\n",norm(param.x_e - param.x_0),norm(param.x_e - param.x),sum(param.z),norm(g_bar - param.g))
        fprintf("x:(%2.10f,%2.10f,%2.10f)\n",param.x(1),param.x(2),param.x(3))
        fprintf("n:(%8.0f,%8.0f,%8.0f,%8.0f,%8.0f)\n",param.n(1),param.n(2),param.n(3),param.n(4),param.n(5))
        g_bar = param.g;
        k = k + 1;
        if k >= 10
            break
        end
    end
    fprintf("Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f\n",norm(param.x_e - param.x_0),norm(param.x_e - x_best),obj_best)
    fprintf("obj_old:%2.12f|obj:%2.12f\n",obj_old,obj_best)
    obj(iter,1) = obj_old;
    obj(iter,2) = obj_best;
    Error(iter,1) = norm(param.x_e - param.x_0);
    Error(iter,2) = norm(param.x_e - x_best);
end
% save('1cm.mat','obj','Error')
% earth