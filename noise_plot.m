clear all
obj_ini = [];
obj_new = [];
err_ini = [];
err_new = [];
load 1cm
mean_obj = mean(obj);
obj_ini = [obj_ini mean_obj(1)];
obj_new = [obj_new mean_obj(2)];
mean_err = mean(Error);
err_ini = [err_ini mean_err(1)];
err_new = [err_new mean_err(2)];
load 01cm
mean_obj = mean(obj);
obj_ini = [obj_ini mean_obj(1)];
obj_new = [obj_new mean_obj(2)];
mean_err = mean(Error);
err_ini = [err_ini mean_err(1)];
err_new = [err_new mean_err(2)];
load 001cm
mean_obj = mean(obj);
obj_ini = [obj_ini mean_obj(1)];
obj_new = [obj_new mean_obj(2)];
mean_err = mean(Error);
err_ini = [err_ini mean_err(1)];
err_new = [err_new mean_err(2)];
figure(1)
Y= [obj_ini',obj_new'];
X=1:length(obj_ini);
h=bar(X,Y);
set(h(1),'FaceColor',[0,1,0])
set(h(2),'FaceColor',[0,1,1])
% set(h(3),'FaceColor',[1,0,0])
ylabel('Log_{10}{(Objective Function)}');
xlabel('Noise Level (cm)');
legend('Initial Function Value','Esitimated Function Value', 'FontSize',8,'FontName','Times New Roman', 'Location', 'northwest');
set(gca,'xtick',1:3);
set(gca,'yscale','log')
set(gca,'XTickLabel',{'1cm','0.1cm','0.01cm'},'FontSize',12,'FontName','Times New Roman'); 
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
set(gca,'xtick',1:4);
set(gca,'yscale','log')
set(gca,'XTickLabel',{'Initial Error','1cm','0.1cm','0.01cm'},'FontSize',12,'FontName','Times New Roman'); 