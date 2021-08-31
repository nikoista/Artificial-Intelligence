%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIAMORFWSH DEDOMENWN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SUMFWNA ME ARITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% XARAKTHRHSTIKWN

function [newDtrn,newDval,newDchk] =  select_Data(Dtrn,Dval,Dchk,new_characteristics,index_mRmR)

%% KAINOURIO DATASET GIA TRAINING
newDtrn = [Dtrn(:,index_mRmR(1:new_characteristics)) Dtrn(:,end)];

%% KAINOURIO DATASET GIA VALIDATION
newDval = [Dval(:,index_mRmR(1:new_characteristics)) Dval(:,end)];

%% KAINOURIO DATASET GIA CHECK
newDchk = [Dchk(:,index_mRmR(1:new_characteristics)) Dchk(:,end)];
end