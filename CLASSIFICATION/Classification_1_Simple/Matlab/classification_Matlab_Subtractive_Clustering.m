%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MATLAB SUBTRACTIVE CLUSTERING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    METHOD

function [ERROR,ACCURACY_ALL,ACCURACY_PROD,...
    ACCURACY_USER,K_est] = classification_Matlab_Subtractive_Clustering(ra,Dtrn,Dval,Dchk,string_radius)
global NUMBER;

model_type = ",Matlab SC ";

%% Dtrn  DEDOMENA EISODOU - DEDOMENA EXODOU
trn_input_DATA  = Dtrn(:,1:end-1);
trn_output_DATA = Dtrn(:,end);

%% Dchk  DEDOMENA EISODOU - DEDOMENA EXODOU
chk_input_DATA  =  Dchk(:,1:end-1);
chk_output_DATA = Dchk(:,end);

%% PRAGMATIKH EXODOS SUSTHMATOS
y=chk_output_DATA;

N = size(ra,2);
dimention = 2;
%% EPANALHPTIKH DIADIKASH GIA KATHE AKRINA EPIROHS
i=1;
while( i<=N)
    
    NUMBER = NUMBER +1;
    %% DHMIOURGIA ENOS TELIKOU MODELOU SUGENO KANONTAS XRHSH  (SC) KAI Dtrn
    options_FuzzyInferenceSystem = genfisOptions('SubtractiveClustering','ClusterInfluenceRange', ra(i));
    trained_FuzzyInferenceSystem = genfis(trn_input_DATA,trn_output_DATA,options_FuzzyInferenceSystem);
    
    %% ALLAZOUME TIS EXODOUS TWN SUNARTHSEWN SUMMETOXHS APO GRAMMIKES SE STATHERES (SINGLENTON)
    %% SUMFWNA ME THN EKFWNHSH TIS ERGASIAS
    M = length(trained_FuzzyInferenceSystem.Output.MembershipFunctions);
    j=1;
    while(j <= M)
        trained_FuzzyInferenceSystem.Output.MembershipFunctions(j).Type = 'constant';
        j=j+1;
    end
    
    %% EKPAIDEUSH TOU MODELOU
    options_ANFIS = anfisOptions('InitialFIS',trained_FuzzyInferenceSystem,'EpochNumber',100,'ValidationData', Dval);
    
    %% AXIOLOGHSH THS APODOSHS TOU MODELOU KANODAS XRHSH   Dval
    [trained_FuzzyInferenceSystem,training_ERROR,~,validation_FuzzyInferenceSystem,validation_ERROR] = anfis(Dtrn,options_ANFIS);
    
    %% EKTIMHSH THS EXODOU KANODAS XRHSH TO EKPAIDEUMENO MODELO KAI TO   Dchk
    y_est = evalfis(validation_FuzzyInferenceSystem,chk_input_DATA);
    
    %% STROGILOPOIHSH STON KODINOTEROS AKERAIO SUMFWNA ME THN EKFWNHSH
    y_estimation = round(y_est);
    
    %% METRIKES AXIOLOGHSHS GIA TO MODELO
    [ERROR,ACCURACY_ALL,ACCURACY_PROD,ACCURACY_USER,K_est] = classification_Eval_Metrics(y,y_estimation,dimention);
    
    %% PLOTS GIA THN AXIOLOGHSH TOU MODELOU ME XRHSH SUNARTHSHS   plot_trn_eval_pred(...)
    simplePlot_trn_eval_pred(y,y_estimation,trained_FuzzyInferenceSystem,training_ERROR,validation_ERROR,model_type,string_radius,i,NUMBER);
    
    %% MERIKA PRINTS GIA TON XRHSH
    fprintf("\n");
    fprintf("*********************************************************\n");
    fprintf("METRIKES AXIOLOGHSHS GIA TO BELTISTO MONTELO ME MATLAB SC\n");
    fprintf("OA  = %.4f\n", double(ACCURACY_ALL));
    fprintf("PA  = [%.4f ,%.4f ] \n", double(ACCURACY_PROD(1)) ,  double(ACCURACY_PROD(2)));
    fprintf("UA  = [%.4f ,%.4f ] \n", double(ACCURACY_USER(1)) ,  double(ACCURACY_USER(2)));
    fprintf("K   = %.4f\n", double(K_est));
    fprintf("ERROR MATRIX  = \n");ERROR
    fprintf("*********************************************************\n");
    fprintf("\n");
    fprintf("Continue... \n");
    
    i=i+1;
end
end