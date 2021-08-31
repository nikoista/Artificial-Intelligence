%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% METRIKES AXIOLOGHSHS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RMSE,R^2,NMSE,NDEI

function [METRICS] =  regression_Eval_Metrics(y,y_est)

%% TUPOI APO KEFALAIO 10 GIA TO RMSE,R^2,NMSE,NDEI
SS_Res = sum((y-y_est).^2);
SS_Tot = sum((y-mean(y)).^2);

R2 = 1 - SS_Res/SS_Tot;
RMSE = sqrt(SS_Res/length(y));
NMSE = SS_Res/SS_Tot;
NDEI = sqrt(NMSE);

[METRICS] = [RMSE ; R2 ; NMSE ; NDEI];

end