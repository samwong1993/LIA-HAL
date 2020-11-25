clear all
cvx_solver MOSEK
dis = 2;
% R = 6371.2;
% M = 4;
% d = 3;
% param = realdata_simulator(R,M,d,dis)
R = 6.364923148106367e+06;  
M = 5;
d = 3;
param = realdata_simulator2(R,M,d,dis,1);
obj_old = objective(param); 
param.x = zeros(1,d);
param.n = zeros(1,M);
[M,d] = size(param.s);
g_bar = zeros(M,1);
for i = 1:M
    g_bar(i) = norm(param.x_0 - param.s(i,:));
end
k = 1;
x_old = param.x_0;
obj_best = 9999;
while(norm(x_old - param.x)>1e-5)
    x_old = param.x;
    param = solve_cvx(param,R,g_bar);
    if param.obj<obj_best
        obj_best = param.obj;
        x_best = param.x;
        n_best = param.n;
        a_rec_best = param.a_rec;
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
param.x = x_best;
param.n = n_best;
param.a_rec = a_rec_best;
fprintf("Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f\n",norm(param.x_e - param.x_0),norm(param.x_e - x_best),obj_best)
%Save the results
fid=fopen("main.txt","a+");
fprintf(fid,"%2.4f,%2.4f,%2.0f,%2.4f,%2.4f\n",norm(param.x_e - param.x_0),norm(param.x_e - x_best),sum(abs(param.n_e - n_best)),obj_old,obj_best);
fclose(fid);
% earth
save noisedata


