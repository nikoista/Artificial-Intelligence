%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TELIKO MODELO TSK ME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BELTISTES TIMES TWN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARAMETRWN KAI TIS IDIES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRODIAGRAFES OPWS KAI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PROHGOUMENWS (SC)

function [METRICS] = multiModel_trn_eval_pred(newDtrn,newDval,newDchk,characteristics,new_ra,ra,ERROR)

i=1;
%% Dtrn  DEDOMENA EISODOU - DEDOMENA EXODOU
trn_input_DATA  = newDtrn(:,1:end-1);
trn_output_DATA = newDtrn(:,end);

%% Dchk  DEDOMENA EISODOU - DEDOMENA EXODOU
chk_input_DATA  =  newDchk(:,1:end-1);
chk_output_DATA = newDchk(:,end);

%% PRAGMATIKH EXODOS SUSTHMATOS
y=chk_output_DATA;

%% METHODO OMADOPOIHSH GIA THN DHMIOURGIA IF-THEN KANONWN KANONTAS XRHSH(SC)
options_FuzzyInferenceSystem = genfisOptions('SubtractiveClustering','ClusterInfluenceRange', new_ra);
trained_FuzzyInferenceSystem = genfis(trn_input_DATA,trn_output_DATA,options_FuzzyInferenceSystem);
TRN_FIS_FIRST = trained_FuzzyInferenceSystem;

%% EKPAIDEUSH TOU MODELOU
options_ANFIS = anfisOptions('InitialFIS',trained_FuzzyInferenceSystem,'EpochNumber',100,'ValidationData', newDval);

%% AXIOLOGHSH THS APODOSHS TOU MODELOU KANODAS XRHSH VALIDATION DATA
[trained_FuzzyInferenceSystem,training_ERROR,~,validation_FuzzyInferenceSystem,validation_ERROR] = anfis(newDtrn,options_ANFIS);
TRN_FIS_FINAL= trained_FuzzyInferenceSystem;

%% EKTIMHSH THS EXODOU KANODAS XRHSH TO EKPAIDEUMENO MODELO KAI TESTING DATA
y_estimation = evalfis(validation_FuzzyInferenceSystem,chk_input_DATA);

%% METRIKES AXIOLOGHSHS GIA TO MODELO
[METRICS] = regression_Eval_Metrics(y,y_estimation);

%% PLOTS GIA THN AXIOLOGHSH TOU MODELOU ME XRHSH SUNARTHSHS   plot_trn_eval_pred(...)
multiPlot_trn_eval_pred(y,y_estimation,TRN_FIS_FIRST,TRN_FIS_FINAL,training_ERROR,validation_ERROR,ERROR,ra,characteristics,i);

%% MERIKA PRINTS GIA TON XRHSH
fprintf("\n");
fprintf("************************************** \n");
fprintf("METRIKES AXIOLOGHSHS GIA TO BELTISTO MONTELO \n");
fprintf("RMSE = %.4f\n", double(METRICS(1)));
fprintf("R^2  = %.4f\n", double(METRICS(2)));
fprintf("NMSE = %.4f\n", double(METRICS(3)));
fprintf("NDEI = %.4f\n", double(METRICS(4)));
fprintf("************************************** \n");
fprintf("\n");
fprintf("Continue... \n");

end
