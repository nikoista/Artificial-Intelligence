%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175
clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CAR CONTROL A

FIS_names = {'First','Final'};





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EPILOGH ARXIKWN SUNTHIKWN 0 H 1
choise = 0;
% choise = 1;

%% EPILOGH ARXIKWN DIEUTHHNSEWN THETA
theta(1) = 0;
% theta(1) = -45;
%  theta(1) = -90;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%% SHMEIA POU APARTIZOUN TA EMPODIA
x1 = [5 5];
x2 = [5 6];
x3 = [6 6];
x4 = [6 7];
x5 = [7 7];
x6 = [7 10];
y1 = [0 1];
y2 = [1 1];
y3 = [1 2];
y4 = [2 2];
y5 = [2 3];
y6 = [3 3];

%% GRAMMES POU DHMOURGOUN TON XWRO TWN EMPODIWN - POLUPLEURO ME PLEURES a,b,c,d,f,g
figure(1);
a = line(x1,y1);
b = line(x2,y2);
c = line(x3,y3);
d = line(x4,y4);
f = line(x5,y5);
g = line(x6,y6);

%% ARITHMOS MEGISTWN EPANALHPSEWN N GIA TO KRITHRIO TERMATISMOU
N = 1000;

%% AKRIVEIA PROSEGISHS SHMEIOU (xd,yd)
epsilon = 0.1;

%% ARXIKOPOIHSH u,theta,hor,ver,dH,dV KAI T = PERIODOS FUZZY CONTROLLER (sec)
T = 1;
u = 0.05;
vert(1) = 0.3;
dv(1) = 1;
hor(1) = 4.1;
dh(1) = 5 - hor(1);

%% ARXHKOPOIHSH TOU FUZZY LOGIC SYSTEM
if(choise == 0)
    FuzzyCarController = readfis('CAR_CONTROL_A_START.fis');
    option = 'First';
else
    FuzzyCarController = readfis('CAR_CONTROL_A_FINAL.fis');
    option = 'Final';
end

%% EPANALHPTIKH METHODOS EYRESHS THESHS AUTOKINHTOU
for i=2:1:N 
    
    i
    
    %% KRITHRIO TERMATISMOU TO SHMEIO xd
    if(abs(hor(i-1) - 10) < epsilon)
        break;
    end
    
    %% AXIOLOGISH MESO FUZZY LOGIC SYSTEM GIA THN GWNIA THETA KAI TO AN THA
    %% GINEI METAVOLH THS THETA GIA APOFUGH EMPODIWN
    evaluation = evalfis([ dv(i-1) , dh(i-1) , theta(i-1) ],FuzzyCarController );
    
    %% ANADROMIKOS UPOLOGISMOS TWN METAVLHTWN 
    theta(i) = theta(i-1) + evaluation;
    vert(i) = vert(i-1) + u*sind(theta(i))*T;
    hor(i) = hor(i-1) + u*cosd(theta(i))*T;
    
    %% UPOLOGISMOS TWN ORIZODIWN KAI KATHETWN APOSTASEWN APO TA EMPODIA 
    %% ORISTIKAN ME TETOIO TROPO WSTE NA FTANW STO SHMEIO (xd,yd)
    if (vert(i)<2 && hor(i)>5)
        dv(i) = vert(i) - 1;
    elseif (vert(i)<3 && hor(i)>6)
        dv(i) = vert(i) - 2;
    elseif (hor(i) > 7)
        dv(i) = vert(i) - 3;
    else
        dv(i) = 1;
    end
    
    if(hor(i)<5 && vert(i)<1)
        dh(i) = 5 - hor(i);
    elseif(hor(i)<6 && vert(i)<2)
        dh(i) = 6 - hor(i);
    elseif(hor(i)<7 && vert(i)<3)
        dh(i) = 7 - hor(i);
    else
        dh(i) = 1;
    end
    
    %% UPOLOGISMOS TWN ORIWN GIA dH
    if (dh(i) > 1)
        dh(i) = 1;
    end
    if (dh(i)<0)
        dh(i) = 0;
    end
     %% UPOLOGISMOS TWN ORIWN GIA dV
    if (dv(i)>1)
        dv(i) = 1;
    end
    if (dv(i)<0)
        dv(i) = 0;
    end
end   

%% UPOLOGISMOS KATHETOU KAI ORTHOGONIOU SFALMATOS THESHS.
ev = 3.2-vert(i-1);
eh = 10-hor(i-1);

%% SXEDIASH THS POREIAS TOU AUTOKINHTOU ,EMFANISH ORIZODIOU KAI KATHETOU SFALMATOS
figure(1);
hold on;
ax = axis;
ylabel('$Horizontal$','Interpreter','latex','fontsize',15);
xlabel('$Vertical$','Interpreter','latex','fontsize',15);
name = strcat(num2str(FIS_names{choise+1}),', Iterations until Desired Position = ',num2str(i-1),' , Theta = ',num2str(theta(1)),'(deg)');
title(name,'Interpreter','latex','fontsize',15);
plot(hor,vert,'red','LineWidth',2);
plot(10,3.2,'g*')
modtxt1 = sprintf('eH = %2.4f',eh);
text(ax(1)+0.6*(ax(2)-ax(1)),ax(4)-0.15*(ax(4)-ax(3)),modtxt1);
modtxt2= sprintf('eV = %2.4f',ev);
text(ax(1)+0.6*(ax(2)-ax(1)),ax(4)-0.3*(ax(4)-ax(3)),modtxt2);
modtxt3 = sprintf('x_est = %2.4f',hor(i-1));
text(ax(1)+0.6*(ax(2)-ax(1)),ax(4)-0.45*(ax(4)-ax(3)),modtxt3);
modtxt4 = sprintf('y_est = %2.4f',vert(i-1));
text(ax(1)+0.6*(ax(2)-ax(1)),ax(4)-0.6*(ax(4)-ax(3)),modtxt4);

