function param = realdata_simulator2(R,M,d,dis)
lambda = 0.19/1000;
emitter  = [3844059.71543,709661.56843,5023129.70605]/1000;
R = norm(emitter);
XYZ(1,:) = [5394000,-1752000,2890000]/1000;  
XYZ(2,:) = [5979000,1943000,995700]/1000;  
XYZ(3,:) = [2645000,3641000,4501000]/1000;  
XYZ(4,:) = [947000,307700,6287000]/1000; 
XYZ(5,:) = [2199000,-3027000,5149000]/1000; 
for i = 1:M
    XYZ(i,:) = XYZ(i,:)/norm(XYZ(i,:))*(21000 + 300*randn);
end
x_0 = emitter + dis / 1000 * randn(1,d);
x_0 = R*x_0 / norm(x_0);
rho = 1.5*norm(emitter - x_0);
for i = 1:M
    n(i) = floor(norm(emitter - XYZ(i,:))/lambda);
end
for i = 1:M
    a(i) = norm(emitter - XYZ(i,:)) - n(i)*lambda;
end
param.x_e = emitter;
param.a = a;
param.s = XYZ;
param.lambda = lambda;
param.x_0 = x_0;
param.n_e = n;
param.x = emitter;
param.n = n;
param.rho = rho;
obj = objective(param);
end