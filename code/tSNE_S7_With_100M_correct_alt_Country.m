%Color: https://www.mathworks.com/help/matlab/creating_plots/specify-plot-colors.html
%Color Shapes: https://www.eggradients.com/shades-of-color

% new appraoch by tsne plotting (matrix: 1125 x 1125)
% this is using the country
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

% % tsne plot barneshut
T_sne_S7_100M_alt_country = tsne(CombinedMatrix_S7_100M_alt,'Algorithm','exact','Distance','cosine');
%T_sne_S6_100M_alt = tsne(CombinedMatrix_S6_100M_alt,'Algorithm','barneshut','Distance','cosine', 'Theta', 0.02);
% % extract data (Top Followers)
tSNE_100M_alt_country = T_sne_S7_100M_alt_country(1:1005,:);
tSNE_table_100M_alt_country = array2table(tSNE_100M_alt_country, 'VariableNames', {'C1', 'C2'});
tSNE_table_100M_alt_country.Category = labelTop_100M_alt_country.('Category');
tSNE_table_100M_alt_country.Country = labelTop_100M_alt_country.('Country');
tSNE_table_100M_alt_country.screen_name = labelTop_100M_alt_country.('users');

% writetable(tSNE_table_100M_alt_country,'tSNE_table_100M_alt_country_CountrySpecific_for_S7.csv','Encoding','UTF-8');

% % country label
Argentina_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Argentina'), :);
Australia_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Australia'), :);
Brazil_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Brazil'), :);
Canada_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Canada'), :);
Chile_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Chile'), :);
China_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'China'), :);
Colombia_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Colombia'), :);
Dominican_Republic_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Dominican Republic'), :);
Egypt_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Egypt'), :);
ElSalvador_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'El Salvador'), :);
France_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'France'), :);
Germany_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Germany'), :);
Guatemala_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Guatemala'), :);
HongKong_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Hong Kong'), :);
India_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'India'), :);
Indonesia_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Indonesia'), :);
Ireland_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Ireland'), :);
Italy_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Italy'), :);
Jamaica_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Jamaica'), :);
Japan_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Japan'), :);
Jordan_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Jordan'), :);
Kuwaiti_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Kuwaiti'), :);
Lebanon_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Lebanon'), :);
Mexico_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Mexico'), :);
Netherlands_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Netherlands'), :);
NewZealand_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'New Zealand'), :);
Nigeria_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Nigeria'), :);
Pakistan_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Pakistan'), :);
Philippines_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Philippines'), :);
PuertoRico_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Puerto Rico'), :); 
Qatar_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Qatar'), :); 
Russia_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Russia'), :); 
SaudiArabia_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Saudi Arabia'), :); 
Serbia_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Serbia'), :); 
SouthAfrica_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'South Africa'), :); 
SouthKorea_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'South Korea'), :); 
Spain_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Spain'), :); 
Sweden_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Sweden'), :); 
Switzerland_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Switzerland'), :); 
Thailand_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Thailand'), :); 
Turkey_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Turkey'), :); 
UAE_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'UAE'), :); 
UnitedKingdom_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'United Kingdom'), :); 
UnitedStates_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'United States'), :); 
Uruguay_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Uruguay'), :); 
VaticanCity_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Vatican City'), :); 
Venezuela_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Venezuela'), :); 
Zimbabwe_100M = tSNE_table_100M_alt_country(strcmp(tSNE_table_100M_alt_country.Country, 'Zimbabwe'), :); 

% % sample with labels
tSNE_S7_100M_alt_country = T_sne_S7_100M_alt_country(1006:1105,:);
tSNE_table_S7_100M_alt_country = array2table(tSNE_S7_100M_alt_country, 'VariableNames', {'C1', 'C2'});
tSNE_table_S7_100M_alt_country.Category = label_S7_country.('Category');
tSNE_table_S7_100M_alt_country.Country = label_S7_country.('Country');
tSNE_table_S7_100M_alt_country.screen_name = label_S7_country.('screen_name');

% writetable(tSNE_table_S7_100M_alt,'tSNE_table_S7_100M_alt_new_CountrySpecific.csv','Encoding','UTF-8');

% % % Note: Sample-7 is currently UNLABELLED
% % % Entertainment_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Entertainment'), :);
% % % Corporate_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Corporate/Company'), :);
% % % News_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'News/Media'), :);
% % % Politics_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Politics'), :);
% % % Religion_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Religion'), :);
% % % Sports_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Sports'), :);

Unlabelled_S7_100M_alt_country = tSNE_table_S7_100M_alt_country(strcmp(tSNE_table_S7_100M_alt_country.Category, 'Unlabeled'), :);

% % color code (Country):
% Argentina - Goldenrod - #daa520
% Australia - Maroon - #800000
% Brazil - Taupe - #b38b6d
% Canada - Burnt - #e97451
% Chile - Olive - #808000
% China - Golden Brown - #996515
% Colombia - Cocoa - #35281E
% Dominican Republic - Umber - #635147
% Egypt - Teal - #008080
% El Salvador - Chartreuse - #7fff00
% France - British Racing Green - #004225
% Germany - Harlequin - #3fff00
% Guatemala - Blue-Violet - #8a2be2
% Hong Kong - Dark Purple - #551a8b
% India - Electric Purple - #bf00ff
% Indonesia - Mulberry - #c54b8c
% Ireland - Periwinkle Blue - #7c9ec3
% Italy - Red Violet - #c71585
% Jamaica - Charcoal - #36454f
% Japan - Yellow Gray - #8f8b66
% Jordan - Eigengrau - #16161d
% Kuwaiti - Navy Blue - #000080
% Lebanon - True Blue - #0073cf
% Mexico - Cyan Blue - #00ffff
% Netherlands - Burnt Orange - #cc5500
% New Zealand - Scarlet - #ff2400
% Nigeria - Redwood - #5b342e
% Pakistan - Citron - #9fa91f
% Philippines - Lemon - #fff44f
% Puerto Rico - Tomato - #ff6347
% Qatar - Magenta - #ff00ff
% Russia - Neon Blue - #4d4dff
% Saudi Arabia - Blood Red - #8A0707
% Serbia - Cornflower Blue - #6488ea
% South Africa - Sea Green - #2e8b57
% South Korea - Dark Green - #006400
% Spain - Moss Green - #addfad
% Sweden - Prussian Blue - #003153
% Switzerland - Tumbleweed - #dcad8d
% Thailand - Gunmetal Gray - #2C3539
% Turkey - Khaki - #bdb76b
% UAE - Sky Blue - #00bfff
% United Kingdom - Chocolate Cosmos - #58111a
% United States - Flame Red - #cf352e
% Uruguay - Muddy Waters - #bf8964
% Vatican City - Lime Green - #32cd32
% Venezuela - Rob Roy - #e9c17b
% Zimbabwe - Sapling - #dcd7a0


% % plot using the Country
figure();
p1 = plot(Argentina_100M.C1, Argentina_100M.C2, '.', 'Color' ,'#daa520', 'MarkerSize',15); 
hold on;
p2 = plot(Australia_100M.C1, Australia_100M.C2, '.', 'Color' ,'#800000', 'MarkerSize',15);
hold on;
p3 = plot(Brazil_100M.C1, Brazil_100M.C2, '.', 'Color' ,'#b38b6d', 'MarkerSize',15);
hold on;
p4 = plot(Canada_100M.C1, Canada_100M.C2, '.', 'Color' ,'#e97451', 'MarkerSize',15);
hold on;
p5 = plot(Chile_100M.C1, Chile_100M.C2, '.', 'Color' ,'#808000', 'MarkerSize',15);
hold on;
p6 = plot(China_100M.C1, China_100M.C2, '.', 'Color' ,'#996515', 'MarkerSize',15);
hold on;
p7 = plot(Colombia_100M.C1, Colombia_100M.C2, '.', 'Color' ,'#35281E', 'MarkerSize',15);
hold on;
p8 = plot(Dominican_Republic_100M.C1, Dominican_Republic_100M.C2, '.', 'Color' ,'#635147', 'MarkerSize',15);
hold on;
p9 = plot(Egypt_100M.C1, Egypt_100M.C2, '.', 'Color' ,'#008080', 'MarkerSize',15);
hold on;
p10 = plot(ElSalvador_100M.C1, ElSalvador_100M.C2, '.', 'Color' ,'#7fff00', 'MarkerSize',15);
hold on;
p11 = plot(France_100M.C1, France_100M.C2, '.', 'Color' ,'#004225', 'MarkerSize',15);
hold on;
p12 = plot(Germany_100M.C1, Germany_100M.C2, '.', 'Color' ,'#3fff00', 'MarkerSize',15);
hold on;
p13 = plot(Guatemala_100M.C1, Guatemala_100M.C2, '.', 'Color' ,'#8a2be2', 'MarkerSize',15);
hold on;
p14 = plot(HongKong_100M.C1, HongKong_100M.C2, '.', 'Color' ,'#551a8b', 'MarkerSize',15);
hold on;
p15 = plot(India_100M.C1, India_100M.C2, '.', 'Color' ,'#bf00ff', 'MarkerSize',15);
hold on;
p16 = plot(Indonesia_100M.C1, Indonesia_100M.C2, '.', 'Color' ,'#c54b8c', 'MarkerSize',15);
hold on;
p17 = plot(Ireland_100M.C1, Ireland_100M.C2, '.', 'Color' ,'#7c9ec3', 'MarkerSize',15);
hold on;
p18 = plot(Italy_100M.C1, Italy_100M.C2, '.', 'Color' ,'#c71585', 'MarkerSize',15);
hold on;
p19 = plot(Jamaica_100M.C1, Jamaica_100M.C2, '.', 'Color' ,'#36454f', 'MarkerSize',15);
hold on;
p20 = plot(Japan_100M.C1, Japan_100M.C2, '.', 'Color' ,'#8f8b66', 'MarkerSize',15);
hold on;
p21 = plot(Jordan_100M.C1, Jordan_100M.C2, '.', 'Color' ,'#16161d', 'MarkerSize',15);
hold on;
p22 = plot(Kuwaiti_100M.C1, Kuwaiti_100M.C2, '.', 'Color' ,'#000080', 'MarkerSize',15);
hold on;
p23 = plot(Lebanon_100M.C1, Lebanon_100M.C2, '.', 'Color' ,'#0073cf', 'MarkerSize',15);
hold on;
p24 = plot(Mexico_100M.C1, Mexico_100M.C2, '.', 'Color' ,'#00ffff', 'MarkerSize',15);
hold on;
p25 = plot(Netherlands_100M.C1, Netherlands_100M.C2, '.', 'Color' ,'#cc5500', 'MarkerSize',15);
hold on;
p26 = plot(NewZealand_100M.C1, NewZealand_100M.C2, '.', 'Color' ,'#ff2400', 'MarkerSize',15);
hold on;
p27 = plot(Nigeria_100M.C1, Nigeria_100M.C2, '.', 'Color' ,'#5b342e', 'MarkerSize',15);
hold on;
p28 = plot(Pakistan_100M.C1, Pakistan_100M.C2, '.', 'Color' ,'#9fa91f', 'MarkerSize',15);
hold on;
p29 = plot(Philippines_100M.C1, Philippines_100M.C2, '.', 'Color' ,'#fff44f', 'MarkerSize',15);
hold on;
p30 = plot(PuertoRico_100M.C1, PuertoRico_100M.C2, '.', 'Color' ,'#ff6347', 'MarkerSize',15);
hold on;
p31 = plot(Qatar_100M.C1, Qatar_100M.C2, '.', 'Color' ,'#ff00ff', 'MarkerSize',15);
hold on;
p32 = plot(Russia_100M.C1, Russia_100M.C2, '.', 'Color' ,'#4d4dff', 'MarkerSize',15);
hold on;
p33 = plot(SaudiArabia_100M.C1, SaudiArabia_100M.C2, '.', 'Color' ,'#8A0707', 'MarkerSize',15);
hold on;
p34 = plot(Serbia_100M.C1, Serbia_100M.C2, '.', 'Color' ,'#6488ea', 'MarkerSize',15);
hold on;
p35 = plot(SouthAfrica_100M.C1, SouthAfrica_100M.C2, '.', 'Color' ,'#2e8b57', 'MarkerSize',15);
hold on;
p36 = plot(SouthKorea_100M.C1, SouthKorea_100M.C2, '.', 'Color' ,'#006400', 'MarkerSize',15);
hold on;
p37 = plot(Spain_100M.C1, Spain_100M.C2, '.', 'Color' ,'#addfad', 'MarkerSize',15);
hold on;
p38 = plot(Sweden_100M.C1, Sweden_100M.C2, '.', 'Color' ,'#003153', 'MarkerSize',15);
hold on;
p39 = plot(Switzerland_100M.C1, Switzerland_100M.C2, '.', 'Color' ,'#dcad8d', 'MarkerSize',15);
hold on;
p40 = plot(Thailand_100M.C1, Thailand_100M.C2, '.', 'Color' ,'#2C3539', 'MarkerSize',15);
hold on;
p41 = plot(Turkey_100M.C1, Turkey_100M.C2, '.', 'Color' ,'#bdb76b', 'MarkerSize',15);
hold on;
p42 = plot(UAE_100M.C1, UAE_100M.C2, '.', 'Color' ,'#00bfff', 'MarkerSize',15);
hold on;
p43 = plot(UnitedKingdom_100M.C1, UnitedKingdom_100M.C2, '.', 'Color' ,'#58111a', 'MarkerSize',15);
hold on;
p44 = plot(UnitedStates_100M.C1, UnitedStates_100M.C2, '.', 'Color' ,'#cf352e', 'MarkerSize',15);
hold on;
p45 = plot(Uruguay_100M.C1, Uruguay_100M.C2, '.', 'Color' ,'#bf8964', 'MarkerSize',15);
hold on;
p46 = plot(VaticanCity_100M.C1, VaticanCity_100M.C2, '.', 'Color' ,'#32cd32', 'MarkerSize',15);
hold on;
p47 = plot(Venezuela_100M.C1, Venezuela_100M.C2, '.', 'Color' ,'#e9c17b', 'MarkerSize',15);
hold on;
p48 = plot(Zimbabwe_100M.C1, Zimbabwe_100M.C2, '.', 'Color' ,'#dcd7a0', 'MarkerSize',15);
hold on;
% include the unlabel dataset
p49 = plot(Unlabelled_S7_100M_alt_country.C1, Unlabelled_S7_100M_alt_country.C2, '*','Color' ,'black', 'MarkerSize',15);
hold on;
h = [p1(1), p2, p3(1), p4, p5(1), p6, p7(1), p8, p9(1), p10, p11(1), p12, p13(1), ...
    p14, p15(1), p16, p17(1), p18, p19(1), p20, p21(1), p22, p23(1), p24, p25(1), ...
    p26, p27(1), p28, p29(1), p30, p31(1), p32, p33(1), p34, p35(1), p36, p37(1), ...
    p38, p39(1), p40, p41(1), p42, p43(1), p44, p45(1), p46, p47(1), p48];
leg1 = legend(h,'Argentina', 'Australia','Brazil', 'Canada', 'Chile', 'China', 'Colombia', ...
        'Dominican Republic', 'Egypt', 'El Salvador', 'France', 'Germany', ...
        'Guatemala', 'Hong Kong', 'India', 'Indonesia', 'Ireland', 'Italy', ...
        'Jamaica', 'Japan', 'Jordan', 'Kuwaiti', 'Lebanon', 'Mexico', ...
        'Netherlands', 'New Zealand', 'Nigeria', 'Pakistan', 'Philippines', 'Puerto Rico', ...
        'Qatar', 'Russia', 'Saudi Arabia', 'Serbia', 'South Africa', 'South Korea', ...
        'Spain', 'Sweden', 'Switzerland', 'Thailand', 'Turkey', 'UAE', ...
        'United Kingdom', 'United States', 'Uruguay', 'Vatican City', 'Venezuela', 'Zimbabwe', ...
        'Location','northeastoutside', 'FontSize', 12);
title(leg1,'Sampling: 100M Top Followers');
grid on;
hold off;
