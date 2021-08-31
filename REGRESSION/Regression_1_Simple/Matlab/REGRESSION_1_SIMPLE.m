%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175
clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REGRESSION ON
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SIMPLE DATATSET

%% EISAGWGH TWN DEDOMENWN AIRFOIL_SELF_NOISE DATASET
DATA = importdata('airfoil_self_noise.dat');

%% KANONIKOPOIHSH SE UNIT HYPERCUBE
preproc = 1;

%% DHMIOURGIA 3 DATASET ME Dtrn U Dval U Dchk = D 
[Dtrn,Dval,Dchk] = split_scale(DATA,preproc);

%% DHMIOURGIA EISODWN - EXODWN ,GAUSSIANES SUNARTHSEWN SUMMETOXHS SUMFWNA
%% ME TON PINAKA STHN EKFWNHSH THS ERGASIAS

inputMembershipFunction = "gbellmf";
outputMembershipFunction = ["constant"  "constant"  "linear"   "linear" ];
numberMembershipFunction = [ 2  3   2   3];
N = size(numberMembershipFunction,2);


%% EKPAIDEUSH MODELOU ME XRHSH BASIKHS SUNARTHSHS simpleModel_trn_eval_pred(...)
[ALL_METRICS] = simpleModel_trn_eval_pred(numberMembershipFunction,...
    inputMembershipFunction,outputMembershipFunction,Dtrn,Dval,Dchk,N);
