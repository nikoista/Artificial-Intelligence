%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CROSS VALIDATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DATASETS

function [Dtrn_Cross , Dval_Cross] = cross_Validation(Dtrn,characteristics,Index_F,i)

%% XRHSHMOPOIOUME RANDOM PERMUTATION GIA EPILOGES STO Dtrn
I = randperm(size(Dtrn,1));
trainPers=0.8;

%% TO 80 % TWN DEDOMENWN XRHSIMOPOIEITAI GIA EKPAIDEUSH KAI TO 20% GIA EPIKURWSH
training_cross1 = Dtrn(I(1:floor(trainPers*length(I))) ,Index_F(1:characteristics(i)));
training_cross2 = Dtrn(I(1:floor(trainPers*length(I))),end);

validation_cross1 = Dtrn(I(ceil(trainPers*length(I)):end),Index_F(1:characteristics(i)));
validation_cross2 = Dtrn(I(ceil(trainPers*length(I)):end),end);

%% XWRIZOUME TO Dtrn KAI Dval SUMFWNA ME THN EKFWNHSH KAI EXOUME Dtrn_Cross  KAI  Dval_Cross
Dtrn_Cross = [training_cross1 training_cross2];
Dval_Cross = [validation_cross1 validation_cross2];
end