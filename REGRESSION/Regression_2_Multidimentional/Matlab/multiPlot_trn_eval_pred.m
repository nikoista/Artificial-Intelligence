%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   PLOTS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  GIA AXIOLOGHSH

function [] =  multiPlot_trn_eval_pred(y,y_est,TRN_FIS_FIRST,TRN_FIS_FINAL,trn_error,val_error,grid_error,ra,characteristics,number)

%% INPUTS START
INPUTS = length(TRN_FIS_FIRST.input);
i=1;


while(i <= INPUTS)
    figure();
    name = strcat("MODELO --- ARXIKOI EISODOI ", int2str(i));
    title(name,'Interpreter','latex','fontsize',15);
    ylabel('$Model$','Interpreter','latex','fontsize',15);
    xlabel('$Input$','Interpreter','latex','fontsize',15);
    hold on;
    plotmf(TRN_FIS_FIRST,'input',i);
    i=i+1;
end
hold off;

%% INPUTS FINAL

INPUTS = length(TRN_FIS_FINAL.input);
i=1;
while(i <= INPUTS)
    figure();
    name = strcat("MODELO ---TELIKOI EISODOI ", int2str(i));
    title(name,'Interpreter','latex','fontsize',15);
    ylabel('$Model$','Interpreter','latex','fontsize',15);
    xlabel('$Input$','Interpreter','latex','fontsize',15);
    hold on;
    plotmf(TRN_FIS_FINAL,'input',i);
    i=i+1;
end
hold off;


%% PLOT GIA THN EKMATHHSH TOU MODELOU
figure();
ylabel('$Error$','Interpreter','latex','fontsize',15);
xlabel('$Number of Epochs$','Interpreter','latex','fontsize',15);
name = strcat("MODELO ", int2str(number)," --- KAMPULH EKMATHHSHS");
title(name,'Interpreter','latex','fontsize',15);
hold on;
plot(trn_error,'blue','LineWidth',2);
plot(val_error,'red','LineWidth',2);
legend('Training Error','Validation Error');
hold off;


%% PLOT GIA TA SFALMATA PROVLEPSHS TOU MODELOU
figure();
ylabel('$Error$','Interpreter','latex','fontsize',15);
xlabel('$Number of Outputs$','Interpreter','latex','fontsize',15);
name = strcat("MODELO ", int2str(number), " --- SFALMATA PROVLEPSHS ");
title(name,'Interpreter','latex','fontsize',15);
hold on;
plot(y-y_est,'r*');
hold off;


%% PLOT GIA TIS EKTIMHSEIS TOU MODELOU KAI TIS PRAGMATIKES TIMES EXODOU
figure();
ylabel('$Value$','Interpreter','latex','fontsize',15);
xlabel('$Number of Outputs$','Interpreter','latex','fontsize',15);
name = strcat("MODELO ", int2str(number), " --- EKTIMOMENES EXODOI");
title(name,'Interpreter','latex','fontsize',15);
hold on;
plot(y,'oc');
plot(y_est,'dr');
legend('Real','Predicted');
hold off;


%% PLOT GIA TO GRID SEARCH KAI MEAN ERROR TOU MODELOU
figure();
hold on;
ax = axis;
ylabel('$Error$','Interpreter','latex','fontsize',15);
xlabel('$Radius$','Interpreter','latex','fontsize',15);
name = 'GRID SEARCH --- MEAN ERROR';
title(name,'Interpreter','latex','fontsize',15);
i=1;
while(i <= length(characteristics))
    plot(ra,grid_error(i,:));
    i=i+1;
end
i=1;
while(i <= length(characteristics))
    plot(ra,grid_error(i,:),'x');
    i=i+1;
end
legend(strcat('Characteristics = ',num2str(characteristics')))
modtxt1 = sprintf('With x Radius of Clusters =[%.2f,%.2f,%.2f,%.2f,%.2f]',ra(1),ra(2),ra(3),ra(4),ra(5));
text(ax(1)+0.5*(ax(2)-ax(1)),ax(4)-0.5*(ax(4)-ax(3)),modtxt1);
% modtxt2 = sprintf('With x Radius of Clusters = %.2f',ra(2));
% text(ax(1)+0.6*(ax(2)-ax(1)),ax(4)-0.3*(ax(4)-ax(3)),modtxt2);
% modtxt3 = sprintf('With x Radius of Clusters = %.2f',ra(3));
% text(ax(1)+0.6*(ax(2)-ax(1)),ax(4)-0.45*(ax(4)-ax(3)),modtxt3);
% modtxt4 = sprintf('With x Radius of Clusters = %.2f',ra(4));
% text(ax(1)+0.6*(ax(2)-ax(1)),ax(4)-0.6*(ax(4)-ax(3)),modtxt4);
% modtxt5 = sprintf('With x Radius of Clusters = %.2f',ra(5));
% text(ax(1)+0.6*(ax(2)-ax(1)),ax(4)-0.75*(ax(4)-ax(3)),modtxt5);
hold off;
end
