%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175
clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DC MOTOR  FLC 4

%% DHMIOURGIA TOU PI ELEGKTH KAI SUNARTHSH METAFORAS Gp   ,  TL=0

%% META APO ANALYSH STO XARTI Kp <= 1,333 KAI Kp/Ki OXI POLU KODA STO 0
Kp=1.3;
Ki=13;

%% ELEGKTHS PI : Kp(s+Kp/KI)/s --- controllerPI 

controllerPI = tf(Kp*[1 ,Ki/Kp],[1 , 0])

%% SUNARTHSH METAFORAS Gp=W(s)/Va(s) --- Gp = zpk([],  -12.064, 18.69)

Gp = tf(18.69,[1 , +12.064])


%% DHMIOURIA SUNARTHSHS ANOIKTOU BROXOU KAI ANALYSH PRODIAGRAFWN   , TL=0

%% SUNARTHSH ANOIKTOU BROXOU
SystemOpenLoopFunction = controllerPI*Gp;

%% PROMOIWSH GIA THN APOKRISH TOU SYSTHMATOS

finalSystem = feedback(SystemOpenLoopFunction,1,-1)
step(finalSystem);
PRODIAGRAFES = stepinfo(finalSystem)

%% ANALYSH MESW TOU CONTROL SYSTEM DESIGNER
controlSystemDesigner(Gp,controllerPI);


%% SXEDIASH TOU PI-Fuzzy Controller.
PIFuzzyController = readfis('FLC_FUZZY_RULES_4.fis');


%% META APO TO RUN TOU ARXEIOU MPOROUME NA ANOIXOUME TA .slx FILES GIA TA
%% SENARIA THS FLC_4 ERGASIAS



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAMDANI.m ARXEIO APO TO ELEARNING YPOLOGISTIKH NOHMOSUNH COPYRIGHTS

fis=PIFuzzyController;

%% Plotting Rule Firing Strength

[x1,y1]=plotmf(fis,'input',1);
[x2,y2]=plotmf(fis,'input',2);
RuleStrength=zeros(length(y1),length(y2));
count=1;


for i=1:3
    for j=1:3
        figure(count);
        subplot(3,3,[1 4]);
        plot(y2(:,j),x2(:,j),'LineWidth',2); grid on;
        legend(fis.input(2).mf(j).name);
        xlabel(fis.input(2).name);
        subplot(3,3,[8 9])
        plot(x1(:,i),y1(:,i),'LineWidth',2); grid on;
        legend(fis.input(1).mf(i).name);
        xlabel(fis.input(1).name);
        Y1=repmat(y1(:,i),[1 length(y1)]);
        Y2=repmat(y2(:,j),[1 length(y2)])';
        Y=min(Y1,Y2);
        subplot(3,3,[2 3 5 6]);
        surf(x1(:,i),x2(:,j),Y);
        title(['Rule # ' num2str(count) 'firing Strength']);
        count=count+1;
        RuleStrength=max(RuleStrength,Y);
    end
end

%% Plot Overall Rule Base
figure;
subplot(3,3,[1 4]);
plot(y2,x2,'LineWidth',2); grid on;
legend(fis.input(2).mf(1).name,fis.input(2).mf(2).name,fis.input(2).mf(3).name);
ylabel(fis.input(2).name);
xlabel('1/2');
title('dE Variable Partition');
subplot(3,3,[8 9]);
plot(x1,y1,'LineWidth',2); grid on;
legend(fis.input(1).mf(1).name,fis.input(1).mf(2).name,fis.input(1).mf(3).name);
xlabel(fis.input(1).name);
ylabel('1/2');
title('e Variable Partition');
subplot(3,3,[2 3 5 6]);
surf(linspace(0,10,length(y1)),linspace(0,10,length(y2)),RuleStrength);
xlabel('$e$');
ylabel('$dE$');
zlabel('1/2');
title('Rule Activation Surface');
zlim([0 1]);

%% MAMDANI.m ARXEIO APO TO ELEARNING YPOLOGISTIKH NOHMOSUNH COPYRIGHTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
