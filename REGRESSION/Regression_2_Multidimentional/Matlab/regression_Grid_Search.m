%% YPOLOGISTIKH NOHMOSUNH 2021 PTUXIAKH EXETASTIKH
%% NIKOLAOS ISTATIADIS  AEM:9175

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GRID SEARCH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ALGORITHMOS

function [gridError,n_char,n_ra] = regression_Grid_Search(characteristics,ra,K_fold,Index_F,Dtrn)

%% ARXIKOPOIHSEIS GIA TO LOOP
MEAN_ERROR = zeros(length(characteristics),length(ra));
RULES = zeros(length(characteristics),length(ra),length(K_fold));
Outside_of_Radius = 0;

%% ARITHMOS EPANALHPSEWN
C = length(characteristics);
A = length(ra);
K = (K_fold);


for i=1:1:1
    for j=1:1:1
        for k=1:1:1
            i
            j
            k
            
            
            %% THA EPILEXOUME SUGEKRIMENO ARITHMO XARAKTHRHSTIKWN SUMFWNA ME TO
            %% RANKING POU VRHKAME KAI THA EFARMOSOUME CROSS VALIDATIONS TO DATASET
            
            [Dtrn_Cross , Dval_Cross] = cross_Validation(Dtrn,characteristics,Index_F,i);
            
            
            
            %% DHMIOURGIA ENOS MODELOU SUGENO KANONTAS XRHSH TRAINING DATA
            %% META APO CROSS VALIADATION
            
            options_FuzzyInferenceSystem = genfisOptions('SubtractiveClustering','ClusterInfluenceRange', ra(j));
            trained_FuzzyInferenceSystem = genfis(Dtrn_Cross(:,1:end-1),Dtrn_Cross(:,end),options_FuzzyInferenceSystem);
            numberOfRules=length(trained_FuzzyInferenceSystem.rule);
            
            %% ELEXOUME AN TO MODELO POU DHMIOURGHSAME EXEI TOULAXISTON 2 KANONES
            if (numberOfRules >= 2)
                
                %% EKPAIDEUSH TOU MODELOU
                options_ANFIS = anfisOptions('InitialFIS',trained_FuzzyInferenceSystem,'EpochNumber',100,'ValidationData', Dval_Cross);
                
                %% AXIOLOGHSH THS APODOSHS TOU MODELOU KANODAS XRHSH VALIDATION DATA
                %% META TO CROSS VALIDATION
                [~,~,~,validation_FuzzyInferenceSystem,validation_ERROR] = anfis(Dtrn_Cross,options_ANFIS);
                
                %% UPOLOGISMOS TOU ARITHMOU TWN KANONWN POU XREIAZONTAI GIA TO GRID SEARCH
                RULES(i,j,k) = length(validation_FuzzyInferenceSystem.rule);
                
                %% UPOLOGISMOS TOU SFALMATOS
                MEAN_ERROR(i,j) = MEAN_ERROR(i,j) + sum(validation_ERROR)/length(validation_ERROR);
            else
                MEAN_ERROR(i,j) = NaN;
                Outside_of_Radius = 1;
                break;
            end
        end
        
        %% DIAIRW TO SFALMA SUMFWNA ME TO k-FOLD
        MEAN_ERROR(i,j) = MEAN_ERROR(i,j) / K_fold;
        if (Outside_of_Radius == 1)
            Outside_of_Radius = 0;
            break;
        end
        
    end
end

%% VRHSKOUME TO ELAXISTO SFALMA TOU GRID SEARCH , EKEI POU KANEI GONATO H KAMPULH
minError = min(MEAN_ERROR(:));
[minRow,minCol] = find(MEAN_ERROR == minError);

%% TELOS DIALEGOUME TA KALHTERA XARAKTHRHSTIKA GIA TO TELIKO MODELO
new_ra = ra(minCol);
new_characteristics = characteristics(minRow);

[gridError] = MEAN_ERROR ;
[n_char] = new_characteristics;
[n_ra] = new_ra;
end