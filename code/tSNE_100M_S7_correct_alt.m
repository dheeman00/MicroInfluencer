% in this script all the different type of labelings are considered
% new appraoch by tsne plotting (matrix: 1125 x 1125)
% this is using the country (Top Followers)

fidTop_100M = fopen('./DistanceMatrixSamples/JoinResults_WithActualMin/NewJS_100M_.csv');
dataTop_100M = cell2mat(textscan(fidTop_100M,'','headerlines',0,'delimiter',',','collectoutput',1));
data_upper_100M = triu(dataTop_100M, 1);
%labelTop = readtable('./DistanceMatrixTopUsers/TopFollowerLabelsUpdated.csv');
labelTop_100M = readtable('./DistanceMatrixSamples/SamplingCountFollowers/TopFollowerLabels_Samples_100M.csv');

% unlabel sample
sample = 7;
str_num = num2str(sample);
file_path_ = strcat('./DistanceMatrixSamples/SampleV3_',str_num,'_New_JS/Sample_',str_num,'_NewJS_WithActualMin_100M_.csv');
fid_S7_100M = fopen(file_path_);
dataSample_S7_100M = cell2mat(textscan(fid_S7_100M,'','headerlines',0,'delimiter',',','collectoutput',1));
label_file_link_S7 = strcat('./DistanceMatrixSamples/ExtractedSamplesV3_Labels/UnLabel_Sample_',str_num,'.csv');
label_S7 = readtable(label_file_link_S7);
fclose('all');

CombinedMatrix_S7_100M_alt = data_upper_100M;
CombinedMatrix_S7_100M_alt(1006:1105,1:1005) = dataSample_S7_100M';
CombinedMatrix_S7_100M_alt(1:1005,1006:1105) = dataSample_S7_100M;
for i = 1:1105
    for j = i+1:1105
        CombinedMatrix_S7_100M_alt(j,i) = CombinedMatrix_S7_100M_alt(i,j);
    end
    CombinedMatrix_S7_100M_alt(i,i) = 1;
end

% tsne plot
T_sne_100M_S7 = tsne(CombinedMatrix_S7_100M_alt,'Algorithm','exact','Distance','cosine');
% % extract data (Top Followers)
tSNE_100M_alt = T_sne_100M_S7(1:1005,:);
tSNE_table_100M = array2table(tSNE_100M_alt, 'VariableNames', {'C1', 'C2'});
tSNE_table_100M.Category = labelTop_100M.('Category');
tSNE_table_100M.Country = labelTop_100M.('Country');
tSNE_table_100M.Language = labelTop_100M.('Language');
tSNE_table_100M.screen_name = labelTop_100M.('users');

writetable(tSNE_table_100M,'tSNE_table_100M_S7_1.csv','Encoding','UTF-8');

% % sample-7 with labels
tSNE_S7_100M_alt = T_sne_100M_S7(1006:1105,:);
tSNE_table_S7_100M_alt = array2table(tSNE_S7_100M_alt, 'VariableNames', {'C1', 'C2'});
tSNE_table_S7_100M_alt.Category = label_S7.('Category');
tSNE_table_S7_100M_alt.Country = label_S7.('Country');
tSNE_table_S7_100M_alt.Language = label_S7.('Language');
tSNE_table_S7_100M_alt.screen_name = label_S7.('screen_name');

writetable(tSNE_table_S7_100M_alt,'tSNE_table_100M_S7_2.csv','Encoding','UTF-8');

Unlabelled_S7_100M_alt = tSNE_table_S7_100M_alt(strcmp(tSNE_table_S7_100M_alt.Category, 'Unlabeled'), :);

%% country label
Argentina_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Argentina'), :);
Australia_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Australia'), :);
Brazil_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Brazil'), :);
Canada_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Canada'), :);
Chile_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Chile'), :);
China_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'China'), :);
Colombia_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Colombia'), :);
Dominican_Republic_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Dominican Republic'), :);
Egypt_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Egypt'), :);
ElSalvador_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'El Salvador'), :);
France_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'France'), :);
Germany_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Germany'), :);
Guatemala_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Guatemala'), :);
HongKong_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Hong Kong'), :);
India_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'India'), :);
Indonesia_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Indonesia'), :);
Ireland_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Ireland'), :);
Italy_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Italy'), :);
Jamaica_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Jamaica'), :);
Japan_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Japan'), :);
Jordan_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Jordan'), :);
Kuwaiti_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Kuwaiti'), :);
Lebanon_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Lebanon'), :);
Mexico_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Mexico'), :);
Netherlands_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Netherlands'), :);
NewZealand_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'New Zealand'), :);
Nigeria_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Nigeria'), :);
Pakistan_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Pakistan'), :);
Philippines_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Philippines'), :);
PuertoRico_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Puerto Rico'), :); 
Qatar_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Qatar'), :); 
Russia_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Russia'), :); 
SaudiArabia_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Saudi Arabia'), :); 
Serbia_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Serbia'), :); 
SouthAfrica_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'South Africa'), :); 
SouthKorea_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'South Korea'), :); 
Spain_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Spain'), :); 
Sweden_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Sweden'), :); 
Switzerland_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Switzerland'), :); 
Thailand_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Thailand'), :); 
Turkey_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Turkey'), :); 
UAE_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'UAE'), :); 
UnitedKingdom_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'United Kingdom'), :); 
UnitedStates_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'United States'), :); 
Uruguay_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Uruguay'), :); 
VaticanCity_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Vatican City'), :); 
Venezuela_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Venezuela'), :); 
Zimbabwe_100M = tSNE_table_100M(strcmp(tSNE_table_100M.Country, 'Zimbabwe'), :); 

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


%% plot using the Country
figure('units','inch','position',[20,12,20,12]); % this is a good fit size for the window
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
p12 = plot(Germany_100M.C1, Germany_100M.C2, '.', 'Color' ,'#3fff00', 'MarkerSize', 15);
hold on;
p13 = plot(Guatemala_100M.C1, Guatemala_100M.C2, '.', 'Color' ,'#8a2be2', 'MarkerSize', 15);
hold on;
p14 = plot(HongKong_100M.C1, HongKong_100M.C2, '.', 'Color' ,'#551a8b', 'MarkerSize', 15);
hold on;
p15 = plot(India_100M.C1, India_100M.C2, '.', 'Color' ,'#bf00ff', 'MarkerSize', 15);
hold on;
p16 = plot(Indonesia_100M.C1, Indonesia_100M.C2, '.', 'Color' ,'#c54b8c', 'MarkerSize', 15);
hold on;
p17 = plot(Ireland_100M.C1, Ireland_100M.C2, '.', 'Color' ,'#7c9ec3', 'MarkerSize', 15);
hold on;
p18 = plot(Italy_100M.C1, Italy_100M.C2, '.', 'Color' ,'#c71585', 'MarkerSize', 15);
hold on;
p19 = plot(Jamaica_100M.C1, Jamaica_100M.C2, '.', 'Color' ,'#36454f', 'MarkerSize', 15);
hold on;
p20 = plot(Japan_100M.C1, Japan_100M.C2, '.', 'Color' ,'#8f8b66', 'MarkerSize', 15);
hold on;
p21 = plot(Jordan_100M.C1, Jordan_100M.C2, '.', 'Color' ,'#16161d', 'MarkerSize', 15);
hold on;
p22 = plot(Kuwaiti_100M.C1, Kuwaiti_100M.C2, '.', 'Color' ,'#000080', 'MarkerSize', 15);
hold on;
p23 = plot(Lebanon_100M.C1, Lebanon_100M.C2, '.', 'Color' ,'#0073cf', 'MarkerSize',15);
hold on;
p24 = plot(Mexico_100M.C1, Mexico_100M.C2, '.', 'Color' ,'#00ffff', 'MarkerSize', 15);
hold on;
p25 = plot(Netherlands_100M.C1, Netherlands_100M.C2, '.', 'Color' ,'#cc5500', 'MarkerSize', 15);
hold on;
p26 = plot(NewZealand_100M.C1, NewZealand_100M.C2, '.', 'Color' ,'#ff2400', 'MarkerSize', 15);
hold on;
p27 = plot(Nigeria_100M.C1, Nigeria_100M.C2, '.', 'Color' ,'#5b342e', 'MarkerSize', 15);
hold on;
p28 = plot(Pakistan_100M.C1, Pakistan_100M.C2, '.', 'Color' ,'#9fa91f', 'MarkerSize', 15);
hold on;
p29 = plot(Philippines_100M.C1, Philippines_100M.C2, '.', 'Color' ,'#fff44f', 'MarkerSize', 15);
hold on;
p30 = plot(PuertoRico_100M.C1, PuertoRico_100M.C2, '.', 'Color' ,'#ff6347', 'MarkerSize',15);
hold on;
p31 = plot(Qatar_100M.C1, Qatar_100M.C2, '.', 'Color' ,'#ff00ff', 'MarkerSize',15);
hold on;
p32 = plot(Russia_100M.C1, Russia_100M.C2, '.', 'Color' ,'#4d4dff', 'MarkerSize', 15);
hold on;
p33 = plot(SaudiArabia_100M.C1, SaudiArabia_100M.C2, '.', 'Color' ,'#8A0707', 'MarkerSize', 15);
hold on;
p34 = plot(Serbia_100M.C1, Serbia_100M.C2, '.', 'Color' ,'#6488ea', 'MarkerSize', 15);
hold on;
p35 = plot(SouthAfrica_100M.C1, SouthAfrica_100M.C2, '.', 'Color' ,'#2e8b57', 'MarkerSize', 15);
hold on;
p36 = plot(SouthKorea_100M.C1, SouthKorea_100M.C2, '.', 'Color' ,'#006400', 'MarkerSize', 15);
hold on;
p37 = plot(Spain_100M.C1, Spain_100M.C2, '.', 'Color' ,'#addfad', 'MarkerSize', 15);
hold on;
p38 = plot(Sweden_100M.C1, Sweden_100M.C2, '.', 'Color' ,'#003153', 'MarkerSize', 15);
hold on;
p39 = plot(Switzerland_100M.C1, Switzerland_100M.C2, '.', 'Color' ,'#dcad8d', 'MarkerSize', 15);
hold on;
p40 = plot(Thailand_100M.C1, Thailand_100M.C2, '.', 'Color' ,'#2C3539', 'MarkerSize', 15);
hold on;
p41 = plot(Turkey_100M.C1, Turkey_100M.C2, '.', 'Color' ,'#bdb76b', 'MarkerSize', 15);
hold on;
p42 = plot(UAE_100M.C1, UAE_100M.C2, '.', 'Color' ,'#00bfff', 'MarkerSize', 15);
hold on;
p43 = plot(UnitedKingdom_100M.C1, UnitedKingdom_100M.C2, '.', 'Color' ,'#58111a', 'MarkerSize', 15);
hold on;
p44 = plot(UnitedStates_100M.C1, UnitedStates_100M.C2, '.', 'Color' ,'#cf352e', 'MarkerSize', 15);
hold on;
p45 = plot(Uruguay_100M.C1, Uruguay_100M.C2, '.', 'Color' ,'#bf8964', 'MarkerSize', 15);
hold on;
p46 = plot(VaticanCity_100M.C1, VaticanCity_100M.C2, '.', 'Color' ,'#32cd32', 'MarkerSize', 15);
hold on;
p47 = plot(Venezuela_100M.C1, Venezuela_100M.C2, '.', 'Color' ,'#e9c17b', 'MarkerSize', 15);
hold on;
p48 = plot(Zimbabwe_100M.C1, Zimbabwe_100M.C2, '.', 'Color' ,'#dcd7a0', 'MarkerSize', 15); 
hold on;
% include the unlabel dataset
p49 = plot(Unlabelled_S7_100M_alt.C1, Unlabelled_S7_100M_alt.C2, 'o','Color' ,'#A2142F', 'MarkerSize',5);
hold on;
h = [p1(1), p2, p3(1), p4, p5(1), p6, p7(1), p8, p9(1), p10, p11(1), p12, p13(1), ...
    p14, p15(1), p16, p17(1), p18, p19(1), p20, p21(1), p22, p23(1), p24, p25(1), ...
    p26, p27(1), p28, p29(1), p30, p31(1), p32, p33(1), p34, p35(1), p36, p37(1), ...
    p38, p39(1), p40, p41(1), p42, p43(1), p44, p45(1), p46, p47(1), p48, p49(1)];
title('\rm 100 Millions Sampled Users from Top Followers in Twitter with Micro-Influencer Samples', 'FontSize', 18);
leg1 = legend(h,'Argentina', 'Australia','Brazil', 'Canada', 'Chile', 'China', 'Colombia', ...
        'Dominican Republic', 'Egypt', 'El Salvador', 'France', 'Germany', ...
        'Guatemala', 'Hong Kong', 'India', 'Indonesia', 'Ireland', 'Italy', ...
        'Jamaica', 'Japan', 'Jordan', 'Kuwaiti', 'Lebanon', 'Mexico', ...
        'Netherlands', 'New Zealand', 'Nigeria', 'Pakistan', 'Philippines', 'Puerto Rico', ...
        'Qatar', 'Russia', 'Saudi Arabia', 'Serbia', 'South Africa', 'South Korea', ...
        'Spain', 'Sweden', 'Switzerland', 'Thailand', 'Turkey', 'UAE', ...
        'United Kingdom', 'United States', 'Uruguay', 'Vatican City', 'Venezuela', 'Zimbabwe', ...
        'Location','northeastoutside', 'FontSize', 12);
labelpoints(tSNE_table_100M.C1,tSNE_table_100M.C2,tSNE_table_100M.screen_name, ...
'C',0.025, 1, 'FontSize', 1.25,  'rotation', 0,  'Color', 'k'); % location label 'SE' % note: C represents much better
labelpoints(Unlabelled_S7_100M_alt.C1,Unlabelled_S7_100M_alt.C2,Unlabelled_S7_100M_alt.screen_name, ...
'C',0.025, 1, 'FontSize', 1.25,  'rotation', 0,  'Color', 'k'); % location label 'SE' % note: C represents much better
title(leg1,'Countries');
grid off;
hold off;
print(gcf,'tSNE_Country_TopFollowers_S7_Unlabelled.png','-dpng','-r1300');

%% plot using the Category

Entertainment_100M_alt = tSNE_table_100M(strcmp(tSNE_table_100M.Category, 'Entertainment'), :);
Corporate_100M_alt = tSNE_table_100M(strcmp(tSNE_table_100M.Category, 'Corporate/Company'), :);
News_100M_alt = tSNE_table_100M(strcmp(tSNE_table_100M.Category, 'News/Media'), :);
Politics_100M_alt = tSNE_table_100M(strcmp(tSNE_table_100M.Category, 'Politics'), :);
Religion_100M_alt = tSNE_table_100M(strcmp(tSNE_table_100M.Category, 'Religion'), :);
Sports_100M_alt = tSNE_table_100M(strcmp(tSNE_table_100M.Category, 'Sports'), :);

figure('units','inch','position',[20,12,20,12]); % this is a good fit size for the window
p1 = plot(Entertainment_100M_alt.C1, Entertainment_100M_alt.C2, '.r','MarkerSize',15);
hold on;
p2 = plot(Corporate_100M_alt.C1, Corporate_100M_alt.C2, '.k', 'MarkerSize',15);
hold on;
p3 = plot(News_100M_alt.C1, News_100M_alt.C2, '.g', 'MarkerSize',15);
hold on;
p4 = plot(Politics_100M_alt.C1, Politics_100M_alt.C2, '.b', 'MarkerSize',15);
hold on; 
p5 = plot(Religion_100M_alt.C1, Religion_100M_alt.C2, '.c', 'MarkerSize',15);
hold on;
p6 = plot(Sports_100M_alt.C1, Sports_100M_alt.C2, '.m', 'MarkerSize',15);
hold on;
p7 = plot(Unlabelled_S7_100M_alt.C1, Unlabelled_S7_100M_alt.C2, 'o','Color' ,'#A2142F', 'MarkerSize',5);
hold on;
labelpoints(tSNE_table_100M.C1,tSNE_table_100M.C2,tSNE_table_100M.screen_name, ...
'C',0.025, 1, 'FontSize', 1.25,  'rotation', 0,  'Color', '#A2142F'); % location label 'SE' % note: C represents much better
hold on;
h = [p1(1), p2, p3(1), p4, p5(1), p6, p7(1)];
hold on;
labelpoints(Unlabelled_S7_100M_alt.C1,Unlabelled_S7_100M_alt.C2,Unlabelled_S7_100M_alt.screen_name, ...
'C',0.025, 1, 'FontSize', 1.25,  'rotation', 0,  'Color', '#A2142F'); % location label 'SE' % note: C represents much better
hold on;
title('\rm 100 Millions Sampled Users from Top Followers in Twitter with Micro-Influencer Samples', 'FontSize', 18);
leg1 = legend(h,'Entertainment','Corporate/Company','News/Media','Politics', 'Religion', 'Sports', ...
    'Location','northeast','FontSize', 12);
title(leg1,'Category');
hold off;
print(gcf,'tSNE_Category_TopFollowers_S7_Unlabelled.png','-dpng','-r1300');

%% language label
Arabic = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Arabic'), :);
Catalan = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Catalan'), :);
English = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'English'), :);
Filipino = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Filipino'), :);
French = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'French'), :);
German = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'German'), :);
Hindi = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Hindi'), :);
Indonesian = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Indonesian'), :);
Italian = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Italian'), :);
Japanese = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Japanese'), :);
Korean = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Korean'), :);
Portuguese = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Portuguese'), :);
Spanish = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Spanish'), :);
Swedish = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Swedish'), :);
Tagalog = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Tagalog'), :);
Tamil = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Tamil'), :);
Telugu = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Telugu'), :);
Thai = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Thai'), :);
Turkish = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Turkish'), :);
Urdu = tSNE_table_100M(strcmp(tSNE_table_100M.Language, 'Urdu'), :);

% color code:
% Arabic        -   red(r)
% Catalan       -   black(k)
% English       -   green(g)
% Filipino      -   blue(b)
% French        -   cyan(c)
% German        -   magenta(m)
% Hindi         -   Goldenrod - #daa520
% Indonesian    -   Olive - #808000
% Italian       -   Cocoa - #35281E
% Japanese      -   Dark Purple - #551a8b
% Korean        -   Yellow Gray - #8f8b66
% Portuguese    -   Sky Blue - #00bfff
% Spanish       -   Tea Color - #d0f0c0
% Swedish       -   Dark Green - #006400
% Tagalog       -   Barbie Pink - #e0218a
% Tamil         -   Watermelon -   #fc6c85
% Telugu        -   Burnt Orange - #cc5500
% Thai          -   Pink - #ff69b4
% Turkish       -   Reseda Green - #587246
% Urdu          -   Rose Red - #c21e56

figure('units','inch','position',[20,12,20,12]); % this is a good fit size for the window
p1 = plot(Arabic.C1, Arabic.C2, '.r','MarkerSize',15);
hold on;
p2 = plot(Catalan.C1, Catalan.C2, '.k', 'MarkerSize',15);
hold on;
p3 = plot(English.C1, English.C2, '.g', 'MarkerSize',15);
hold on;
p4 = plot(Filipino.C1, Filipino.C2, '.b', 'MarkerSize',15);
hold on; 
p5 = plot(French.C1, French.C2, '.c', 'MarkerSize',15);
hold on;
p6 = plot(German.C1, German.C2, '.m', 'MarkerSize',15);
hold on;
p7 = plot(Hindi.C1, Hindi.C2, '.', 'Color', '#daa520', 'MarkerSize',15);
hold on;
p8 = plot(Indonesian.C1, Indonesian.C2, '.', 'Color', '#808000', 'MarkerSize',15);
hold on;
p9 = plot(Italian.C1, Italian.C2, '.', 'Color', '#35281E', 'MarkerSize',15);
hold on;
p10 = plot(Japanese.C1, Japanese.C2, '.', 'Color', '#551a8b', 'MarkerSize',15);
hold on;
p11 = plot(Korean.C1, Korean.C2, '.', 'Color', '#8f8b66', 'MarkerSize',15);
hold on;
p12 = plot(Portuguese.C1, Portuguese.C2, '.', 'Color', '#00bfff', 'MarkerSize',15);
hold on;
p13 = plot(Spanish.C1, Spanish.C2, '.', 'Color', '#d0f0c0', 'MarkerSize',15);
hold on;
p14 = plot(Swedish.C1, Swedish.C2, '.', 'Color', '#006400', 'MarkerSize',15);
hold on;
p15 = plot(Tagalog.C1, Tagalog.C2, '.', 'Color', '#e0218a', 'MarkerSize',15);
hold on;
p16 = plot(Tamil.C1, Tamil.C2, '.', 'Color', '#fc6c85', 'MarkerSize',15);
hold on;
p17 = plot(Telugu.C1, Telugu.C2, '.', 'Color', '#cc5500', 'MarkerSize',15);
hold on;
p18 = plot(Thai.C1, Thai.C2, '.', 'Color', '#ff69b4', 'MarkerSize',15);
hold on;
p19 = plot(Turkish.C1, Turkish.C2, '.', 'Color', '#587246', 'MarkerSize',15);
hold on;
p20 = plot(Urdu.C1, Urdu.C2, '.', 'Color', '#c21e56', 'MarkerSize',15);
hold on;
p21 = plot(Unlabelled_S7_100M_alt.C1, Unlabelled_S7_100M_alt.C2, 'o','Color' ,'#A2142F', 'MarkerSize',5);
hold on;
h = [p1(1); p2; p3(1); p4; p5(1); p6;p7(1);p8;p9(1);p10; ... 
    p11(1);p12;p13(1);p14;p15(1);p16;p17(1);p18;p19(1);p20;p21(1)];
title('\rm 100 Millions Sampled Users from Top Followers in Twitter with Micro-Influencer Samples', 'FontSize', 18);
labelpoints(tSNE_table_100M.C1,tSNE_table_100M.C2,tSNE_table_100M.screen_name, ...
'C',0.025, 1, 'FontSize', 1.25,  'rotation', 0,  'Color', 'k'); % location label 'SE' % note: C represents much better
leg1 = legend(h,'Arabic','Catalan','English','Filipino', 'French', 'German', ...
    'Hindi', 'Indonesian', 'Italian', 'Japanese', 'Korean', 'Portuguese', 'Spanish', ...
    'Swedish', 'Tagalog', 'Tamil', 'Telugu', 'Thai', 'Turkish', 'Urdu', ...
    'Location','northeastoutside', 'FontSize', 12);
labelpoints(Unlabelled_S7_100M_alt.C1,Unlabelled_S7_100M_alt.C2,Unlabelled_S7_100M_alt.screen_name, ...
'C',0.025, 1, 'FontSize', 1.25,  'rotation', 0,  'Color', '#A2142F'); % location label 'SE' % note: C represents much better
title(leg1,'Language');
grid off;
hold off;
print(gcf,'tSNE_Language_TopFollowers_S7_Unlabelled.png.png','-dpng','-r1300');
