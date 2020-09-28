R = 6.364923148106367e+03;
figure('color','k')
ha=axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'down')
img=imread('background.jpg');
image(img)
colormap gray
set(ha,'handlevisibility','off','visible','off');
rotate3d on
hold on
%Add legend
%emitter
point1 = scatter3(0,0,0,50,'filled','r');
%sensors
point2 = scatter3(0,0,0,'filled','c');
%initial point
point3 = scatter3(0,0,0,50,'filled','b');
%recover location
point4 = scatter3(0,0,0,50,'k*');
%generated sequence
point5 = scatter3(0,0,0,5,'m');
%plot earth
npanels = 72;
alpha   = 1;
image_file = 'earth.jpg';
[x0, y0, z0] = ellipsoid(0, 0, 0, R, R, R);
globe = surf(x0, y0, -z0, 'FaceColor', 'none', 'EdgeColor', 0.5*[1 1 1]);
cdata = imread(image_file);
set(gca, 'NextPlot','add', 'Visible','off');
set(globe, 'FaceColor', 'texturemap', 'CData', cdata, 'FaceAlpha', alpha, 'EdgeColor', 'none');
axis off;
axis equal;
axis auto;
[M,d] = size(param.s);
for i = 1:M
    xyz = param.s(i,:);
    xyz = [xyz;param.x_e];
    comet3(xyz(:,1),xyz(:,2),xyz(:,3),0.1);
    point2 = scatter3(param.s(i,1),param.s(i,2),param.s(i,3),'filled','c');
end
point1 = scatter3(param.x_e(1),param.x_e(2),param.x_e(3),50,'filled','r');
point3 = scatter3(param.x(1),param.x(2),param.x(3),50,'k*');
legend([point1,point2,point3],'Emitter', 'Sensors','Estimated Location','AutoUpdate','off');
grid on
rotate3d on
[x,y,z] = sphere(30);
x = param.x_0(1) + param.rho*x;
y = param.x_0(2) + param.rho*y;
z = param.x_0(3) + param.rho*z;
surf(x,y,z)


