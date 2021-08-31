%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175
clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REGRESSION ON
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MULTIDIMENTIONAL DATATSET

%% EISAGWGH TWN DEDOMENWN SUPERCONDUCTIVITY DATASET
DATA = importdata('train.csv');
DATA = DATA.data;

%% KANONIKOPOIHSH SE UNIT HYPERCUBE
preproc = 1;

%% DHMIOURGIA 3 DATASET ME Dtrn U Dval U Dchk = D 
[Dtrn,Dval,Dchk] = split_scale(DATA,preproc);

%% EISAGWGH RANK FETURES ME XRHSH Minimum Redundancy Feature Selection ALGORITHMO
[index_mRmR,scores_mRmR] = fscmrmr(Dtrn(:,1:end-1),Dtrn(:,end));

%% K-FOLD GIA CROSS VALIDATION  GIA K = 5
K_fold = 5;

%% ARXIKOPOIHSH TOU ARITHMOU XARAKTIRISTIKWN KAI AKRINAS EPIRROHS
characteristics = [6 8 10 12 14];
ra = [0.2 0.35 0.5 0.65 0.8];
% ra = [  0.2 0.35 0.5 0.65  0.8];
% characteristics = [4 6 8 10 12];


%% METHODO GRID SEARCH 
[grid_Error,new_characteristics,new_ra] = regression_Grid_Search(characteristics,ra,K_fold,index_mRmR,Dtrn);

%% DIALEGOUME SUGEKRIMENO ARITHMO XARAKTHRISTIKWN POU VRHKAME KAI DIAMORFWNOUME
%% TA KAINOURIA DEDOMENA 
[newDtrn,newDval,newDchk] =  select_Data(Dtrn,Dval,Dchk,new_characteristics,index_mRmR);

%% DHMIOURGIA TELIKOU BELTISTOU TSK MONTELOU KAI AXIOLOGHSHS TOU
multiModel_trn_eval_pred(newDtrn,newDval,newDchk,characteristics,new_ra,ra,grid_Error);