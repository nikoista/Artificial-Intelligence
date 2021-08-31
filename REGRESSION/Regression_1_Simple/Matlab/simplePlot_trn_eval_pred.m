%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOTS MONTELOU 
function [] =  simplePlot_trn_eval_pred(y,y_est,trn_fis,trn_error,val_error,number)

%% PLOT GIA TIS SUNARTHSEIS SUMMETOXHS TOU MODELOU
close all;

INPUTS = length(trn_fis.input);
i=1;
figure(i);
name = strcat("MODELO ", int2str(number), " --- EISODOI");
title(name,'Interpreter','latex','fontsize',15);
while(i <= INPUTS)
    subplot(INPUTS,1,i)
    ylabel('$Model$','Interpreter','latex','fontsize',15);
    xlabel('$Input$','Interpreter','latex','fontsize',15);
    hold on;
    plotmf(trn_fis,'input',i);
    i=i+1;
end
hold off;

%% PLOT GIA THN KAMPULH EKMATHHSH TOU MODELOU
figure(i+1);
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
figure(i+2);
ylabel('$Error$','Interpreter','latex','fontsize',15);
xlabel('$Number of Outputs$','Interpreter','latex','fontsize',15);
name = strcat("MODELO ", int2str(number), " --- SFALMATA PROVLEPSHS ");
title(name,'Interpreter','latex','fontsize',15);
hold on;
plot(y-y_est,'r*');
hold off;

%% PLOT GIA TIS EKTIMHSEIS TOU MODELOU KAI TIS PRAGMATIKES TIMES EXODOU
figure(i+3);
ylabel('$Real Values$','Interpreter','latex','fontsize',15);
xlabel('$Number of Outputs$','Interpreter','latex','fontsize',15);
name = strcat("MODELO ", int2str(number), " --- EKTIMOMENES EXODOI");
title(name,'Interpreter','latex','fontsize',15);
hold on;
plot(y,'ob');
plot(y_est,'xr');
legend('Real','Predicted');
hold off;
end
