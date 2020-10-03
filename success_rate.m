load results
sum = succ_sum + fail_sum + bett_sum;
succ_rate = succ_sum./sum;
fail_rate = fail_sum./sum;
bett_rate = bett_sum./sum;
Y=[succ_rate',bett_rate',fail_rate'];
X=1:length(succ_rate);
h=bar(X,Y);
set(h(1),'FaceColor',[0,1,0])
set(h(2),'FaceColor',[0,1,1])
set(h(3),'FaceColor',[1,0,0])
ylim([0,1]);
ylabel('Rate (%)');
xlabel('Initial Error (m)');
legend('Optimal Solution','Better Solution','Worse Solution', 'FontSize',8,'FontName','Times New Roman', 'Location', 'northwest');
set(gca,'xtick',1:25);
set(gca,'XTickLabel',{'[0,1]','[1,2]','[2,3]','[3,4]','[4,5]','[5,6]','[6,7]','[7,8]','[8,9]','[9,10]','[10,11]','[11,12]','[12,13]','[13,14]','[14,15]','[15,16]','[16,17]','[17,18]','[18,19]','[19,20]','[20,21]','[21,22]','[22,23]','[23,24]','[24,25]'},'FontSize',12,'FontName','Times New Roman'); 
Y_1=roundn(Y,-2);
for i = 1:length(X)
    text(X(i)-0.25,Y_1(i,1),num2str(Y_1(i,1)),'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',8,'FontName','Times New Roman');
    text(X(i),Y_1(i,2),num2str(Y_1(i,2)),'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',8,'FontName','Times New Roman');
    text(X(i)+0.25,Y_1(i,3),num2str(Y_1(i,3)),'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',8,'FontName','Times New Roman');
end
set(gcf,'PaperType','a2');
saveas(gcf,sprintf('results.pdf'),'pdf'); 