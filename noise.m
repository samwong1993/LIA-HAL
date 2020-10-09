clear all
cvx_solver gurobi_2
R = 6.364923148106367e+03;
% param.x_e = [3844.05971543000,709.661568430000,5023.12970605000];
% param.s = [17813.6634032310,-5785.97298525412,9544.21342887238;20029.9156249593,6509.13632033717,3335.63923528550;8649.78014678761,11906.9374345761,14719.3423216223;3164.40765522023,1028.18187487990,21008.0580025022;7316.78624474036,-10071.8108061978,17132.3930760201];
% param.lambda = 0.19/1000;
% param.n_e = [84503322,90926816,81958450,84223899,87269162];
% param.x_0 = [3844.05913297447,709.661298843919,5023.13018987354];
% param.a = [2.77105264103739e-05,9.20307102205697e-05,0.000162797465236508,7.42248357710196e-05,0.000178195175976725];
% param.n = param.n_e;
% param.x = param.x_e;
load noisedata
a_e = param.a;
param.rho = 1.5*norm(param.x_0 - param.x_e);
[M,d] = size(param.s);
param.a = param.a + 1e-6*randn(1,M);
obj_old = objective(param); 
g_bar = zeros(M,1);
for i = 1:M
    g_bar(i) = norm(param.x_e - param.s(i,:));
end
k = 1;
x_old = param.x_0;
obj_best = 9999;
while(1000*norm(x_old - param.x)>1e-12)
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
fprintf("obj_old:%2.12f|obj:%2.12f\n",obj_old,obj_best)
% earth