%Color: https://www.mathworks.com/help/matlab/creating_plots/specify-plot-colors.html
%Color Shapes: https://www.eggradients.com/shades-of-color

% new appraoch by tsne plotting (matrix: 1125 x 1125)
% This is using all the Category for the 100M Samples of Top Followers
%% 100M from Top 1000 against Sample-7 (with actual total followers from the sample 100M)
fidTop_100M_alt_country = fopen('./DistanceMatrixSamples/JoinResults_WithActualMin/NewJS_100M_.csv');
dataTop_100M_alt_country = cell2mat(textscan(fidTop_100M_alt_country,'','headerlines',0,'delimiter',',','collectoutput',1));
data_upper_100M_alt_country = triu(dataTop_100M_alt_country, 1);
%labelTop = readtable('./DistanceMatrixTopUsers/TopFollowerLabelsUpdated.csv');
labelTop_100M_alt_country = readtable('./DistanceMatrixSamples/SamplingCountFollowers/TopFollowerLabels_Samples_100M.csv');

sample = 7;
str_num = num2str(sample);
file_path_ = strcat('./DistanceMatrixSamples/SampleV3_',str_num,'_New_JS/Sample_',str_num,'_NewJS_WithActualMin_100M_.csv');
fid_S7_100M_country = fopen(file_path_);
dataSample_S7_100M_country = cell2mat(textscan(fid_S7_100M_country,'','headerlines',0,'delimiter',',','collectoutput',1));
label_file_link_S7_country = strcat('./DistanceMatrixSamples/ExtractedSamplesV3_Labels/UnLabel_Sample_',str_num,'.csv');
label_S7_country = readtable(label_file_link_S7_country);
fclose('all');

CombinedMatrix_S7_100M_alt_country = data_upper_100M_alt_country;
CombinedMatrix_S7_100M_alt_country(1006:1105,1:1005) = dataSample_S7_100M_country';
CombinedMatrix_S7_100M_alt_country(1:1005,1006:1105) = dataSample_S7_100M_country;
for i = 1:1105
    for j = i+1:1105
        CombinedMatrix_S7_100M_alt_country(j,i) = CombinedMatrix_S7_100M_alt_country(i,j);
    end
    CombinedMatrix_S7_100M_alt_country(i,i) = 1;
end


CombinedMatrix_100M_alt_country = CombinedMatrix_S7_100M_alt_country(1:1005, 1:1005);

% tsne plot barneshut
T_sne_S7_100M_alt_country = tsne(CombinedMatrix_100M_alt_country,'Algorithm','exact','Distance','cosine');
%T_sne_S6_100M_alt = tsne(CombinedMatrix_S6_100M_alt,'Algorithm','barneshut','Distance','cosine', 'Theta', 0.02);
% % extract data (Top Followers)
tSNE_100M_alt_country = T_sne_S7_100M_alt_country(1:1005,:);
tSNE_table_100M_alt_country = array2table(tSNE_100M_alt_country, 'VariableNames', {'C1', 'C2'});
tSNE_table_100M_alt_country.Category = labelTop_100M_alt_country.('Category');
tSNE_table_100M_alt_country.Country = labelTop_100M_alt_country.('Country');
tSNE_table_100M_alt_country.screen_name = labelTop_100M_alt_country.('users');

writetable(tSNE_table_100M_alt_country,'tSNE_table_100M_Category_TopFollowers.csv','Encoding','UTF-8');

AllCountries_100M_Corporate_only = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Category, 'Corporate/Company'), :);
AllCountries_100M_Entertainment_only = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Category, 'Entertainment'), :);
AllCountries_100M_News_only = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Category, 'News/Media'), :);
AllCountries_100M_Politics_only = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Category, 'Politics'), :);
AllCountries_100M_Religion_only = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Category, 'Religion'), :);
AllCountries_100M_Sports_only = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Category, 'Sports'), :);

% % sample with labels
% tSNE_S7_100M_alt_country = T_sne_S7_100M_alt_USA(1006:1105,:);
% tSNE_table_S7_100M_alt_country = array2table(tSNE_S7_100M_alt_country, 'VariableNames', {'C1', 'C2'});
% tSNE_table_S7_100M_alt_country.Category = label_S7_country.('Category');
% tSNE_table_S7_100M_alt_country.Country = label_S7_country.('Country');
% tSNE_table_S7_100M_alt_country.screen_name = label_S7_country.('screen_name');
% 
% writetable(tSNE_table_S7_100M_alt,'tSNE_table_S7_100M_alt_new_CountrySpecific.csv','Encoding','UTF-8');

% % Note: Sample-7 is currently UNLABELLED
% Entertainment_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Entertainment'), :);
% Corporate_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Corporate/Company'), :);
% News_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'News/Media'), :);
% Politics_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Politics'), :);
% Religion_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Religion'), :);
% Sports_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Sports'), :);

% Unlabelled_S7_100M_alt_country = tSNE_table_S7_100M_alt_country(strcmp(tSNE_table_S7_100M_alt_country.Category, 'Unlabeled'), :);

% color code:
% Entertainment     -   red(r)
% Corporate/Company -   black(k)
% News/Media        -   green(g)
% Politics          -   blue(b)
% Religion          -   cyan(c)
% Sports            -   magenta(m)

% plotting (Top Followers)
% % this displaying window size in full
% figure('Position', get(0, 'Screensize'));
figure('units','inch','position',[20,12,20,12]); % this is a good fit size for the window

% p1 = plot(UnitedStates_100M_Entertainment_only.C1, UnitedStates_100M_Entertainment_only.C2, '.r','MarkerSize',15);
% hold on;
% p2 = plot(UnitedStates_100M_Corporate_only.C1, UnitedStates_100M_Corporate_only.C2, '.k', 'MarkerSize',15);
% hold on;
% p3 = plot(UnitedStates_100M_News_only.C1, UnitedStates_100M_News_only.C2, '.g', 'MarkerSize',15);
% hold on;
% p4 = plot(UnitedStates_100M_Politics_only.C1, UnitedStates_100M_Politics_only.C2, '.b', 'MarkerSize',15);
% hold on; 
% p5 = plot(UnitedStates_100M_Religion_only.C1, UnitedStates_100M_Religion_only.C2, '.c', 'MarkerSize',15);
% hold on;
% p6 = plot(UnitedStates_100M_Sports_only.C1, UnitedStates_100M_Sports_only.C2, '.m', 'MarkerSize',15);
% h = [p1(1);p2;p3(1);p4; p5(1); p6];
% leg1 = legend(h,'Entertainment','Corporate/Company','News/Media','Politics', 'Religion', 'Sports', ...
%         'Location','NorthEast');
% title(leg1,'Sampling: 100M Top Followers (USA)');
% grid on;
% hold off;

% alternative plot
%h = gscatter(tSNE_table_100M_alt_country.C1,tSNE_table_100M_alt_country.C2, ...
%    tSNE_table_100M_alt_country.Category, 'rkgbcm', 'o');
gscatter(tSNE_table_100M_alt_country.C1,tSNE_table_100M_alt_country.C2, ...
    tSNE_table_100M_alt_country.Category, 'rkgbcm'); %indicator: , 'o'
%set(h,'LineWidth',1);
%text(UnitedStates_100M_only.C1,UnitedStates_100M_only.C2,UnitedStates_100M_only.screen_name,'FontSize', 8, ...
%    'VerticalAlignment','top','HorizontalAlignment','left');
% labelpoints(tSNE_table_100M_alt_country.C1,tSNE_table_100M_alt_country.C2,tSNE_table_100M_alt_country.screen_name, ...
% 'SE',0.05,1, 'FontSize', 1.25,  'rotation', -45,  'Color', '#A2142F');
labelpoints(tSNE_table_100M_alt_country.C1,tSNE_table_100M_alt_country.C2,tSNE_table_100M_alt_country.screen_name, ...
'C',0.025, 1, 'FontSize', 1.25,  'rotation', 0,  'Color', '#A2142F'); % location label 'SE' % note: C represents much better
title('\rm 100 Millions Sampled Users from Top Followers in Twitter', 'FontSize', 18);
leg1 = legend('Location','northeast','FontSize', 12);
title(leg1,'Category');
print(gcf,'tSNE_Category_TopFollowers.png','-dpng','-r1300');

