clear all
cvx_solver MOSEK
tol = 3;
dis = 2;
succ_sum = zeros(1,tol);
fail_sum = zeros(1,tol);
bett_sum = zeros(1,tol);
for iter = 1:10000
    succ = zeros(1,tol);
    fail = zeros(1,tol);
    bett = zeros(1,tol);
    % R = 6371.2;
    % M = 4;
    % d = 3;
    % param = realdata_simulator(R,M,d,dis)
    R = 6.364923148106367e+06;
    M = 5;
    d = 3;
    param = realdata_simulator2(R,M,d,dis,1);
    if norm(param.x_0 - param.x_e) > tol %|| norm(param.x_0 - param.x_e) < 14
        continue
    end
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
%         fprintf("Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f|Dif_g:%2.4f\n",norm(param.x_e - param.x_0),norm(param.x_e - param.x),sum(param.z),norm(g_bar - param.g))
%         fprintf("x:(%2.10f,%2.10f,%2.10f)\n",param.x(1),param.x(2),param.x(3))
%         fprintf("n:(%8.0f,%8.0f,%8.0f,%8.0f,%8.0f)\n",param.n(1),param.n(2),param.n(3),param.n(4),param.n(5))
        g_bar = param.g;
        k = k + 1;
        if k >= 10
            break
        end
    end
    param.x = x_best;
    param.n = n_best;
    param.a_rec = a_rec_best;
    fprintf("Iter:%d|Initial Error:%2.4f|Error:%2.4f|Obj:%2.4f\n",iter,norm(param.x_e - param.x_0),norm(param.x_e - x_best),obj_best)
    index = ceil(norm(param.x_e - param.x_0));
    if norm(param.x_e - x_best) < 1e-2
        succ(index) = succ(index) + 1;
    else if norm(param.x_e - x_best) < norm(param.x_0 - param.x_e)
            bett(index) = bett(index) + 1;
        else
            fail(index) = fail(index) + 1;
        end 
    end

    %Save the results
    succ_sum = succ_sum + succ;
    fail_sum = fail_sum + fail;
    bett_sum = bett_sum + bett;
    fid=fopen("repeat4.txt","a+");
    fprintf(fid,"succ_sum:%2d",succ_sum(1));
    for i = 2:length(succ_sum)
        fprintf(fid,",%2d",succ_sum(i));
    end
    fprintf(fid,"\n");
    fprintf(fid,"fail_sum:%2d",fail_sum(1));
    for i = 2:length(fail_sum)
        fprintf(fid,",%2d",fail_sum(i));
    end
    fprintf(fid,"\n");
    fprintf(fid,"bett_sum:%2d",bett_sum(1));
    for i = 2:length(bett_sum)
        fprintf(fid,",%2d",bett_sum(i));
    end
    fprintf(fid,"\n");
    fprintf(fid,"\n");
    fclose(fid);

end




