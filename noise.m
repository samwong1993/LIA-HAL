clear all
cvx_solver gurobi_2
R = 6.364923148106367e+03;
param.x_e = [3844.05971543000,709.661568430000,5023.12970605000];
param.s = [17851.5394696554,-5798.27533385916,9564.50668655992;19199.5772677792,6239.30065751715,3197.36060972199;8742.31494062634,12034.3170884010,14876.8089027445;3100.70519000082,1007.48361875739,20585.1462825081;7192.14678840430,-9900.24025852652,16840.5474367866];
param.lambda = 0.19/1000;
param.n_e = [84733055,86434812,83107199,82013719,85423998];
param.x_0 = [3844.06240956414,709.658793193432,5023.12803638525];
param.a = [0.000175801827936084,2.31239901040681e-05,0.000159383789650747,0.000163261453053565,2.16338412428740e-06];
param.n = param.n_e;
param.x = param.x_e;
param.rho = 1.5*norm(param.x_0 - param.x_e);
[M,d] = size(param.s);
param.a = param.a + 1e-7*randn(1,M);
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
1e5*(param.a - [0.000175801827936084,2.31239901040681e-05,0.000159383789650747,0.000163261453053565,2.16338412428740e-06])

% earth