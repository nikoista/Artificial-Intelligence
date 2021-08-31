%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CUSTOM SUBTRACTIVE CLUSTERING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  METHOD


function [ERROR,ACCURACY_ALL,ACCURACY_PROD,...
    ACCURACY_USER,K_est] = classification_Custom_Subtractive_Clustering(ra,...
    characteristics,Dtrn,Dval,Dchk,string_radius)
global NUMBER;

model_type = " ,Custom SC";

%% Dchk  DEDOMENA EISODOU - DEDOMENA EXODOU
chk_input_DATA  =  Dchk(:,1:end-1);
chk_output_DATA = Dchk(:,end);

%% PRAGMATIKH EXODOS SUSTHMATOS
y=chk_output_DATA;

N = size(ra,2);
dimention = 2;

i=1;
while( i<=N)
    i
    NUMBER = NUMBER +1;
    %% DHMIOURGIA ENOS TELIKOU MODELOU SUGENO KANONTAS XRHSH  (SC) KAI Dtrn
    trained_FuzzyInferenceSystem = genfis_Custom_Subtractive_Clustering(dimention,characteristics,ra(i),Dtrn);
    
    %% EKPAIDEUSH TOU MODELOU
    options_ANFIS = anfisOptions('InitialFIS',trained_FuzzyInferenceSystem,'EpochNumber',100,'ValidationData', Dval);
    
    %% AXIOLOGHSH THS APODOSHS TOU MODELOU KANODAS XRHSH   Dval
    [trained_FuzzyInferenceSystem,training_ERROR,~,validation_FuzzyInferenceSystem,validation_ERROR] = anfis(Dtrn,options_ANFIS);
    
    %% EKTIMHSH THS EXODOU KANODAS XRHSH TO EKPAIDEUMENO MODELO KAI TO   Dchk
    y_est = evalfis(validation_FuzzyInferenceSystem,chk_input_DATA);
    
    %% STROGILOPOIHSH STON KODINOTEROS AKERAIO
    y_estimation = round(y_est);
    
    %% METRIKES AXIOLOGHSHS GIA TO MODELO
    [ERROR,ACCURACY_ALL,ACCURACY_PROD,ACCURACY_USER,K_est] = classification_Eval_Metrics(y,y_estimation,dimention);
    
    %% PLOTS GIA THN AXIOLOGHSH TOU MODELOU ME XRHSH SUNARTHSHS   plot_trn_eval_pred(...)
    simplePlot_trn_eval_pred(y,y_estimation,trained_FuzzyInferenceSystem,training_ERROR,validation_ERROR,model_type,string_radius,i,NUMBER);
    
    %% MERIKA PRINTS GIA TON XRHSH
    fprintf("\n");
    fprintf("*********************************************************\n");    fprintf("METRIKES AXIOLOGHSHS GIA TO BELTISTO MONTELO ME CUSTOM SC \n");
    fprintf("OA  = %.4f\n", double(ACCURACY_ALL));
    fprintf("PA  = [%.4f ,%.4f ] \n", double(ACCURACY_PROD(1)) ,  double(ACCURACY_PROD(2)));
    fprintf("UA  = [%.4f ,%.4f ] \n", double(ACCURACY_USER(1)) ,  double(ACCURACY_USER(2)));
    fprintf("K   = %.4f\n", double(K_est));
    fprintf("ERROR MATRIX  = \n");ERROR
    fprintf("*********************************************************\n");    fprintf("\n");
    fprintf("Continue... \n");
    
    i=i+1;
end
end