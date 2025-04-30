% new appraoch by tsne plotting (matrix: 1125 x 1125)
% this is using the continent
%% 100M from Top 1000 against Sample-7 (with actual total followers from the sample 100M)
fidTop_100M_alt_continent = fopen('./DistanceMatrixSamples/JoinResults_WithActualMin/NewJS_100M_.csv');
dataTop_100M_alt_continent = cell2mat(textscan(fidTop_100M_alt_continent,'','headerlines',0,'delimiter',',','collectoutput',1));
data_upper_100M_alt_continent = triu(dataTop_100M_alt_continent, 1);
%labelTop = readtable('./DistanceMatrixTopUsers/TopFollowerLabelsUpdated.csv');
labelTop_100M_alt_continent = readtable('./DistanceMatrixSamples/SamplingCountFollowers/TopFollowerLabels_Samples_100M.csv');

sample = 7;
str_num = num2str(sample);
file_path_ = strcat('./DistanceMatrixSamples/SampleV3_',str_num,'_New_JS/Sample_',str_num,'_NewJS_WithActualMin_100M_.csv');
fid_S7_100M_continent = fopen(file_path_);
dataSample_S7_100M_continent = cell2mat(textscan(fid_S7_100M_continent,'','headerlines',0,'delimiter',',','collectoutput',1));
label_file_link_S7_continent = strcat('./DistanceMatrixSamples/ExtractedSamplesV3_Labels/UnLabel_Sample_',str_num,'.csv');
label_S7_continent = readtable(label_file_link_S7_continent);
fclose('all');

CombinedMatrix_S7_100M_alt_continent = data_upper_100M_alt_continent;
CombinedMatrix_S7_100M_alt_continent(1006:1105,1:1005) = dataSample_S7_100M_continent';
CombinedMatrix_S7_100M_alt_continent(1:1005,1006:1105) = dataSample_S7_100M_continent;
for i = 1:1105
    for j = i+1:1105
        CombinedMatrix_S7_100M_alt_continent(j,i) = CombinedMatrix_S7_100M_alt_continent(i,j);
    end
    CombinedMatrix_S7_100M_alt_continent(i,i) = 1;
end

% % tsne plot barneshut
T_sne_S7_100M_alt_dataSample_S7_100M_continent = tsne(CombinedMatrix_S7_100M_alt_continent,'Algorithm','exact','Distance','cosine');
%T_sne_S6_100M_alt = tsne(CombinedMatrix_S6_100M_alt,'Algorithm','barneshut','Distance','cosine', 'Theta', 0.02);
% % extract data (Top Followers)
tSNE_100M_alt_dataSample_S7_100M_continent = T_sne_S7_100M_alt_dataSample_S7_100M_continent(1:1005,:);
tSNE_table_100M_alt_dataSample_S7_100M_continent = array2table(tSNE_100M_alt_dataSample_S7_100M_continent, 'VariableNames', {'C1', 'C2'});
tSNE_table_100M_alt_dataSample_S7_100M_continent.Category = labelTop_100M_alt_continent.('Category');
tSNE_table_100M_alt_dataSample_S7_100M_continent.Country = labelTop_100M_alt_continent.('Country');
tSNE_table_100M_alt_dataSample_S7_100M_continent.screen_name = labelTop_100M_alt_continent.('users');

%writetable(tSNE_table_100M_alt_dataSample_S7_100M_continent,'tSNE_table_100M_alt_for_S7.csv','Encoding','UTF-8');

% convert to categorical
tSNE_table_100M_alt_dataSample_S7_100M_continent.Country = categorical(tSNE_table_100M_alt_dataSample_S7_100M_continent.Country);

% extract the data based on continent
SouthAmerica_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Argentina' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Brazil' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Chile' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Colombia' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Uruguay' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Venezuela');
SouthAmerica = tSNE_table_100M_alt_dataSample_S7_100M_continent(SouthAmerica_index, :);

Caribbean_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Dominican Republic' | ...
                   tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Jamaica' | ...
                   tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Puerto Rico');
Caribbean = tSNE_table_100M_alt_dataSample_S7_100M_continent(Caribbean_index, :);

NorthAmerica_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Canada' | ...
                   tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Mexico' | ...
                   tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'United States');
NorthAmerica = tSNE_table_100M_alt_dataSample_S7_100M_continent(NorthAmerica_index, :);

CentralAmerica_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'El Salvador' | ...
                   tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Guatemala');
CentralAmerica = tSNE_table_100M_alt_dataSample_S7_100M_continent(CentralAmerica_index, :);

Europe_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'France' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Germany' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Ireland' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Italy' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Netherlands' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Russia' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Serbia' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Spain' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Sweden' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Switzerland' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'United Kingdom' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Vatican City');
Europe = tSNE_table_100M_alt_dataSample_S7_100M_continent(Europe_index, :);

MiddleEast_Asia_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Jordan' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Kuwaiti' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Lebanon' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Qatar' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Saudi Arabia' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Turkey' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'UAE');
MiddleEast_Asia = tSNE_table_100M_alt_dataSample_S7_100M_continent(MiddleEast_Asia_index, :);

SouthEast_Asia_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Indonesia' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Philippines' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Thailand');
SouthEast_Asia = tSNE_table_100M_alt_dataSample_S7_100M_continent(SouthEast_Asia_index, :);

South_Asia_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'India' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Pakistan');
South_Asia = tSNE_table_100M_alt_dataSample_S7_100M_continent(South_Asia_index, :);

East_Asia_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'China' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Hong Kong' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Japan' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'South Korea');
East_Asia = tSNE_table_100M_alt_dataSample_S7_100M_continent(East_Asia_index, :);

Africa_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'China' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Hong Kong' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Japan' | ...
                    tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'South Korea');
Africa = tSNE_table_100M_alt_dataSample_S7_100M_continent(Africa_index, :);

Oceania_index = (tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'Australia' | ...
                tSNE_table_100M_alt_dataSample_S7_100M_continent.Country == 'New Zealand');
Oceania = tSNE_table_100M_alt_dataSample_S7_100M_continent(Oceania_index, :);

% % sample with labels
tSNE_S7_100M_alt_continent = T_sne_S7_100M_alt_dataSample_S7_100M_continent(1006:1105,:);
tSNE_table_S7_100M_alt_continent = array2table(tSNE_S7_100M_alt_continent, 'VariableNames', {'C1', 'C2'});
tSNE_table_S7_100M_alt_continent.Category = label_S7.('Category');
tSNE_table_S7_100M_alt_continent.Country = label_S7.('Country');
tSNE_table_S7_100M_alt_continent.screen_name = label_S7.('screen_name');

% writetable(tSNE_table_S7_100M_alt,'tSNE_table_S7_100M_alt_new.csv','Encoding','UTF-8');
 
Unlabelled_S7_100M_alt_continent = tSNE_table_S7_100M_alt_continent(strcmp(tSNE_table_S7_100M_alt_continent.Category, 'Unlabeled'), :);

% % color code:
% % SouthAmerica     -   red(r)
% % Caribbean        -   black(k)
% % NorthAmerica     -   green(g)
% % Europe           -   blue(b)
% % CentralAmerica   -   cyan(c)
% % MiddleEast_Asia  -   magenta(m)
% % SouthEast_Asia   -   Muddy Waters   -   #bf8964
% % South_Asia       - Burnt Orange     -   #cc5500
% % East_Asia        - Olive            -   #808000
% % Africa           - Prussian Blue    -   #003153
% % Oceania          -    Sky Blue      -   #00bfff
% % Unlabelled        -   #A2142F

% plotting (Top Followers)
figure();
p1 = plot(SouthAmerica.C1, SouthAmerica.C2, '.r','MarkerSize',15);
hold on;
p2 = plot(Caribbean.C1, Caribbean.C2, '.k', 'MarkerSize',15);
hold on;
p3 = plot(NorthAmerica.C1, NorthAmerica.C2, '.g', 'MarkerSize',15);
hold on;
p4 = plot(Europe.C1, Europe.C2, '.b', 'MarkerSize',15);
hold on; 
p5 = plot(CentralAmerica.C1, CentralAmerica.C2, '.c', 'MarkerSize',15);
hold on;
p6 = plot(MiddleEast_Asia.C1, MiddleEast_Asia.C2, '.m', 'MarkerSize',15);
hold on;
p7 = plot(SouthEast_Asia.C1, SouthEast_Asia.C2, '.', 'Color', '#bf8964', 'MarkerSize',15);
hold on;
p8 = plot(South_Asia.C1, South_Asia.C2, '.', 'Color', '#cc5500', 'MarkerSize',15);
hold on;
p9 = plot(East_Asia.C1, East_Asia.C2, '.', 'Color', '#808000', 'MarkerSize',15);
hold on;
p10 = plot(Africa.C1, Africa.C2, '.', 'Color', '#003153', 'MarkerSize',15);
hold on;
p11 = plot(Oceania.C1, Oceania.C2, '.', 'Color', '#00bfff', 'MarkerSize',15);
hold on;
p12 = plot(Unlabelled_S7_100M_alt_continent.C1, Unlabelled_S7_100M_alt_continent.C2, '*','Color' ,'#A2142F', 'MarkerSize',15);


h = [p1(1); p2; p3(1); p4; p5(1); p6; p7(1); p8; p9(1); p10; p11(1)];
leg1 = legend(h,'SouthAmerica', 'Caribbean', 'NorthAmerica', 'Europe', 'CentralAmerica', 'MiddleEastAsia', ...
    'SouthEastAsia', 'SouthAsia', 'EastAsia', 'Africa', 'Oceania','Location','NorthEast');
title(leg1,'Sampling: 100M Top Followers');
grid on;
hold off;

% % alternative plot
% %gscatter(T_sne(1006:1125,1),T_sne(1006:1125,2),table2array(label_S6(:,6)),'k','*',8);
% %hold on;
% %gscatter(T_sne(1:1005,1),T_sne(1:1005,2),table2array(labelTop(:,5)));


