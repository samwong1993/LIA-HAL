function param = solve_n(param)
    obj = objective(param);
    for i = 1:100000
        n = param.n;
        obj_old = obj;
        g_n = grad_n(param);
        n = n - 0.001*g_n;
        param.n = n;
        obj = objective(param);
        if abs(obj-obj_old)<1e-7
            break
        end
    end
end