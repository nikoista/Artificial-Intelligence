%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% METRIKES AXIOLOGHSHS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CLASSIFICATION

function [error,accuracy_all,accuracy_prod,...
    accuracy_user,k_est] = classification_Eval_Metrics(y,y_est,N)

%% ARXIKOPOIHSH TWN METRIKWN
error = zeros(N,N);
accuracy_prod = zeros(1,N);
accuracy_user = zeros(1,N);

chk_N = size(y,1);
[I1] = find(y_est <1);
[ IN] = find(y_est >N);
y_est(I1) = 1;
y_est(IN) = N;

%% UPOLOGIZOUME TO ERROR SUMFWNA ME TON TUPO
k=1;
while( k <= chk_N)
    error(y_est(k),y(k,end)) = error(y_est(k),y(k,end)) + 1;
    k=k+1;
end

%% UPOLOGIZOUME TO USER,PRODUCER ACCURACY SUMFWNA ME TOUS TUPOUS
prod_sum = sum(error,1);
user_sum = sum(error,2);
i=1;
while( i <= N)
    accuracy_prod(i) = error(i,i) / prod_sum(i);
    accuracy_user(i) = error(i,i) / user_sum(i);
    i=i+1;
end

%% TELOS UPOLOGIZOUME TO K ektimhsh SUMFWNA ME TON TUPO
k_est = (chk_N*trace(error) - sum(prod_sum.*user_sum))/ (chk_N^2 - sum(prod_sum.*user_sum));

%% UPOLOGIZOUME TO TELIKO ACCURACY SUMFWNA ME TON TUPO
accuracy_all = trace(error)/chk_N;


end
