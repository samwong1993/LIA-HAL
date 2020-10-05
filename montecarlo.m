clear all
cvx_solver gurobi_2
dis = 10;
tol = 25;
succ = zeros(1,tol);
fail = zeros(1,tol);
bett = zeros(1,tol);
for iter = 1:10000
    % R = 6371.2;
    % M = 4;
    % d = 3;
    % param = realdata_simulator(R,M,d,dis)
    R = 6.364923148106367e+03;
    M = 5;
    d = 3;
    param = realdata_simulator2(R,M,d,dis);
    if 1000*norm(param.x_0 - param.x_e) > tol || 1000*norm(param.x_0 - param.x_e) < 18
        continue
    end
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
    fprintf("Iter:%d|Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f\n",iter,1000*norm(param.x_e - param.x_0),1000*norm(param.x_e - x_best),1e6*obj_best)
    index = ceil(norm(param.x_e - param.x_0)*1000);
    if 1000*norm(param.x_e - x_best) < 1e-2
        succ(index) = succ(index) + 1;
    else if 1000*norm(param.x_e - x_best) < 1000*norm(param.x_0 - param.x_e)
            bett(index) = bett(index) + 1;
        else
            fail(index) = fail(index) + 1;
        end 
    end
end
load results
succ_sum = succ_sum + succ;
fail_sum = fail_sum + fail;
bett_sum = bett_sum + bett;
save('results.mat','succ_sum','fail_sum','bett_sum')




