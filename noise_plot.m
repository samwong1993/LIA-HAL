clear all
obj_ini = [];
obj_new = [];
err_ini = [];
err_new = [];
filename = '.\results0.005.txt';
[ini,err,dis,obj_old,obj]=textread(filename,'%f%f%f%f%f','delimiter',',');
Y = [mean(ini);mean(err);mean(dis);mean(obj_old);mean(obj)];
obj_ini = [obj_ini,mean(obj_old)];
obj_new = [obj_new,mean(obj)];
err_ini = [err_ini,mean(ini)];
err_new = [err_new,mean(err)];
filename = '.\results0.004.txt';
[ini,err,dis,obj_old,obj]=textread(filename,'%f%f%f%f%f','delimiter',',');
Y = [mean(ini);mean(err);mean(dis);mean(obj_old);mean(obj)];
obj_ini = [obj_ini,mean(obj_old)];
obj_new = [obj_new,mean(obj)];
err_ini = [err_ini,mean(ini)];
err_new = [err_new,mean(err)];
filename = '.\results0.003.txt';
[ini,err,dis,obj_old,obj]=textread(filename,'%f%f%f%f%f','delimiter',',');
Y = [mean(ini);mean(err);mean(dis);mean(obj_old);mean(obj)];
obj_ini = [obj_ini,mean(obj_old)];
obj_new = [obj_new,mean(obj)];
err_ini = [err_ini,mean(ini)];
err_new = [err_new,mean(err)];
filename = '.\results0.002.txt';
[ini,err,dis,obj_old,obj]=textread(filename,'%f%f%f%f%f','delimiter',',');
Y = [mean(ini);mean(err);mean(dis);mean(obj_old);mean(obj)];
obj_ini = [obj_ini,mean(obj_old)];
obj_new = [obj_new,mean(obj)];
err_ini = [err_ini,mean(ini)];
err_new = [err_new,mean(err)];
filename = '.\results0.001.txt';
[ini,err,dis,obj_old,obj]=textread(filename,'%f%f%f%f%f','delimiter',',');
Y = [mean(ini);mean(err);mean(dis);mean(obj_old);mean(obj)];
obj_ini = [obj_ini,mean(obj_old)];
obj_new = [obj_new,mean(obj)];
err_ini = [err_ini,mean(ini)];
err_new = [err_new,mean(err)];
filename = '.\results0.0005.txt';
[ini,err,dis,obj_old,obj]=textread(filename,'%f%f%f%f%f','delimiter',',');
Y = [mean(ini);mean(err);mean(dis);mean(obj_old);mean(obj)];
obj_ini = [obj_ini,mean(obj_old)];
obj_new = [obj_new,mean(obj)];
err_ini = [err_ini,mean(ini)];
err_new = [err_new,mean(err)];




Y= [obj_ini',obj_new'];
X=1:length(obj_ini);
h=bar(X,Y);
set(h(1),'FaceColor',[0,1,0])
set(h(2),'FaceColor',[0,1,1])
% set(h(3),'FaceColor',[1,0,0])
ylabel('Log_{10}{(Objective Function)}');
xlabel('Noise Level (cm)');
legend('Initial Function Value','Esitimated Function Value', 'FontSize',8,'FontName','Times New Roman', 'Location', 'northwest');
set(gca,'xtick',1:6);
set(gca,'yscale','log')
set(gca,'XTickLabel',{'0.5cm','0.4cm','0.3cm','0.2cm','0.1cm','0.05cm'},'FontSize',12,'FontName','Times New Roman'); 
Y_1=Y;
for i = 1:length(X)
    text(X(i)-0.25,Y_1(i,1),num2str(Y_1(i,1)),'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',8,'FontName','Times New Roman');
    text(X(i)+0.25,Y_1(i,2),num2str(Y_1(i,2)),'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',8,'FontName','Times New Roman');
end

figure(2)
Y= [err_ini(1);err_new'];
b=diag(Y);
c=bar(b,0.5,'stack');
color=[1,0,1;0.62745,0.12549,0.94118;1,0.64706,0;0.80392,0.78824,0.78824];
for i=1:4
set(c(i),'FaceColor',color(i,:));
end
Y_1 = Y;
for i = 1:length(Y)
    text(i,Y_1(i),num2str(Y_1(i)),'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',8,'FontName','Times New Roman');
end
ylabel('Log_{10}{(Localization Error)} (m)');
xlabel('Noise Level (cm)');
set(gca,'xtick',1:7);
set(gca,'yscale','log')
set(gca,'XTickLabel',{'Error at x_0','0.5cm','0.4cm','0.3cm','0.2cm','0.1cm','0.05cm'},'FontSize',12,'FontName','Times New Roman'); 