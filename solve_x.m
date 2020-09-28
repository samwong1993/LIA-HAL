function param = solve_x(param)
    obj = objective(param);
    rho = param.rho;
    x_0 = param.x_0;
    for i = 1:100000
        x = param.x;
        obj_old = obj;
        g_x = grad_x(param);
        x = x - 0.001*g_x;
        if norm(x - x_0) > rho
            x = (x - x_0)/norm(x - x_0)*rho + x_0;
        end
        param.x = x;
        obj = objective(param);
        if abs(obj-obj_old)<1e-10
            break
        end
    end
end