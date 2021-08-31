%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EPANALHPTIKH DIADIKASIA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EKPAIDEUSHS TOU MODELOU

function [ALL_METRICS] = simpleModel_trn_eval_pred(numberMembershipFunction,inputMembershipFunction,outputMembershipFunction,Dtrn,Dval,Dchk,N)

ALL_METRICS = zeros(4,4);

%% Dtrn  DEDOMENA EISODOU - DEDOMENA EXODOU
trn_input_DATA =  Dtrn(:,1:end-1);
trn_output_DATA = Dtrn(:,end);

%% Dchk  DEDOMENA EISODOU - DEDOMENA EXODOU
chk_input_DATA =  Dchk(:,1:end-1);
chk_output_DATA = Dchk(:,end);

%% PRAGMATIKH EXODOS SUSTHMATOS
y=chk_output_DATA;

i=1;
while( i <= N )
    i
    
    %% DHMIOURGIA ENOS MODELOU SUGENO KANONTAS XRHSH    Dtrn
    options_FuzzyInferenceSystem = genfisOptions('GridPartition', 'NumMembershipFunctions',numberMembershipFunction(i), 'InputMembershipFunctionType', inputMembershipFunction,'OutputMembershipFunctionType', outputMembershipFunction(i));
    trained_FuzzyInferenceSystem= genfis(trn_input_DATA,trn_output_DATA,options_FuzzyInferenceSystem);
    
    %% EKPAIDEUSH TOU MODELOU
    options_ANFIS = anfisOptions('InitialFIS',trained_FuzzyInferenceSystem,'EpochNumber',100,'ValidationData', Dval);
    
    %% AXIOLOGHSH THS APODOSHS TOU MODELOU KANODAS XRHSH   Dval
    [trained_FuzzyInferenceSystem,training_ERROR,~,validation_FuzzyInferenceSystem,validation_ERROR] = anfis(Dtrn,options_ANFIS);
    
    %% EKTIMHSH THS EXODOU KANODAS XRHSH TO EKPAIDEUMENO MODELO KAI TO   Dchk
    y_estimation = evalfis(chk_input_DATA,validation_FuzzyInferenceSystem);
    
    %% METRIKES AXIOLOGHSHS GIA TO MODELO
    [METRICS] = regression_Eval_Metrics(y,y_estimation);
    
    %% PLOTS GIA THN AXIOLOGHSH TOU MODELOU ME XRHSH SUNARTHSHS   plot_trn_eval_pred(...)
    simplePlot_trn_eval_pred(y,y_estimation,trained_FuzzyInferenceSystem,training_ERROR,validation_ERROR,i);
    
    %% MERIKA PRINTS GIA TON XRHSH
    fprintf("\n");
    fprintf("************************************** \n");
    fprintf("METRIKES AXIOLOGHSHS GIA TO %d MONTELO \n",i);
    fprintf("RMSE = %.4f\n", double(METRICS(1)));
    fprintf("R^2  = %.4f\n", double(METRICS(2)));
    fprintf("NMSE = %.4f\n", double(METRICS(3)));
    fprintf("NDEI = %.4f\n", double(METRICS(4)));
    fprintf("************************************** \n");
    fprintf("\n");
    fprintf("Continue... \n");
    
    ALL_METRICS(1,i) = METRICS(1);
    ALL_METRICS(2,i) = METRICS(2);
    ALL_METRICS(3,i) = METRICS(3);
    ALL_METRICS(4,i) = METRICS(4);
    i=i+1;
end
end