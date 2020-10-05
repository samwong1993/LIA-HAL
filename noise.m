param.x_e = [3844.05971543000,709.661568430000,5023.12970605000];
param.s = [17785.7298483616,-5776.90001748787,9529.24717496572;20052.3369523451,6516.42259548528,3339.37312317277;8814.38533689700,12133.5262803939,14999.4511914455;3100.30222684437,1007.35268764521,20582.4710667060;7034.22549325843,-9682.85610190690,16470.7717438780];
lambda = 0.19/1000;
param.n_e = [84333913,91048335,84002343,81999746,83089593];
param.x_0 = [3844.05768873478,709.670533992142,5023.12999037080];
param.a = [4.09014683100395e-05,0.000170180930581409,6.56640331726521e-05,8.21882513264427e-05,0.000147635333632934];
param.n = param.n_e;
param.x = param.x_e;
[M,d] = size(param.s);
param.a = param.a + 1e-5*randn(1,M);
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