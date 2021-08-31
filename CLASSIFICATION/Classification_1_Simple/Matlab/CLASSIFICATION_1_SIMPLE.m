%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175
clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CLASSIFICATION ON
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SIMPLE DATATSET

global NUMBER;
NUMBER = 0;

%% EISAGWGH TWN DEDOMENWN HABERMAN DATASET
DATA = importdata('HABERMAN.data');

%% KANONIKOPOIHSH SE UNIT HYPERCUBE
preproc = 1;

%% DHMIOURGIA 3 DATASET ME Dtrn U Dval U Dchk = D 
[Dtrn,Dval,Dchk] = split_scale(DATA,preproc);

string_radius1 = ["R=0,1","R=0,2","R=0,3","R=0,4","R=0,5"];
string_radius2 = ["R=0,9","R=0,8","R=0,7","R=0,6","R=0,5"];


%% EPANALHPTIKH DIADIKASIA GIA DIAFORES AKTINES 
%% STHN EKFWNHSH LEEI GIA 2 AKRAIA TIMES OPOTE MPORW KATEUTHIAN NA PARW 
%% [0.1,0.9] H [0.2,0.8]

a=0;
for i=1:1:5
%% ARXIKOPOIHSH AKRINAS EPIRROHS
ra = [0.1 + a ,  0.8-a ];

string_radius = {string_radius1{i}, string_radius2{i}};

%% ARXIKOPOIHSH XARAKTHRHSTIKWN
characteristics = 3;

%% MATLAB METHODO SUBTRACTIVE CLUSTERING GIA EKPAIDEUSH TWN  n = 1,2 PRWTWN MODELWN
[ERROR,ACCURACY_ALL,ACCURACY_PROD,...
ACCURACY_USER,K_est] = classification_Matlab_Subtractive_Clustering(ra,Dtrn,Dval,Dchk,string_radius);

%% METHODO CUSTOM SUBTRACTIVE CLUSTERING GIA EKPAIDEUSH TWN  n = 3,4 TELEFTAIWN MODELWN
[ERROR_c,ACCURACY_ALL_c,ACCURACY_PROD_c...
,ACCURACY_USER_c,K_est_c] = classification_Custom_Subtractive_Clustering(ra,...
characteristics,Dtrn,Dval,Dchk,string_radius);

METRICS_CS_MATLAB{i} = {ERROR,ACCURACY_ALL,ACCURACY_PROD,ACCURACY_USER,K_est};
METRICS_CS_CUSTOM{i} = {ERROR_c,ACCURACY_ALL_c,ACCURACY_PROD_c,ACCURACY_USER_c,K_est_c};

NUMBER = 0;
a=a +0.1;
i
end
