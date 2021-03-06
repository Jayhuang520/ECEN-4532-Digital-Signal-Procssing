clear all;close all;clc;
tic
pathName = 'C:\Users\JayHuang\OneDrive\Documents\CU Boulder\2017 Spring\ECEN 4532\lab 3';
fileList = dir(fullfile(pathName,'*.wav'));
fileName = dir('*.wav');
NumSong = size(fileName,1);
mfcc1 = cell(150,1);
Chrome1 = cell(150,1);
fftSize = 512;
w = hann(fftSize);
fftSizeC = 2048; 
gamma = 100;
NumSec = 120;

%---------------For the effect of the different length of the song
% using gamma as 100
parfor i = 1:NumSong
    %--------Extract the length---------%
    [song,fs] = audioread(fileName(i).name);
    ExtractedSong = SongExtract(song,NumSec,fs);
     mfccCoe = mfcc(ExtractedSong,fs,fftSize,w);
    % demochrom('track201-classical');
    mfcc1{i} = Cov_Mu(mfccCoe);
    Chrome1{i} = mychroma(ExtractedSong',fs,fftSizeC);
end

MfccD = zeros(150,150);
chromeD = zeros(150,150);

for i = 1:NumSong
    for j = 1:i
        %---assignment 1: distance matrix--------------
        MfccD(i,j) = distance(mfcc1{i},mfcc1{j},gamma);
        MfccD(j,i) = MfccD(i,j);
        chromeD(i,j) = distance(Chrome1{i},Chrome1{j},gamma);
        chromeD(j,i) = chromeD(i,j);
    end
end
genreList = {'classical','electronic','jazz','metal','rock','world'};
% 
% 3. For each genre, compute the histogram composed of the 300 pairwise distances within that
% genre. Plot the six histograms on the same figure. Comment on the figure.
% index = 1;
% figure
% for i = 1:25:150
%     subplot(3,2,index)
%     his1 = triu(MfccD(i:i+24,i:i+24),1);
%     his2 = nonzeros(his1);
%     histogram(his2,50);
%     title(genreList(index));
%     index = index + 1;
% end
% saveas(gcf,'Historgram_for_Mfcc_distance.png');
% 
% figure
% index2 = 1;
% for j = 1:25:150
%     subplot(3,2,index2);
%     his1 = triu(chromeD(j:j+24,j:j+24),1);
%     his2 = nonzeros(his1);
%     histogram(his2,50);
%     title(genreList(index2));
%     index2 = index2 + 1;
% end
% saveas(gcf,'Histogram_for_Chroma_distance.png');
% %----------------------end of problem 3----------------

DMFCCavg = zeros(6,6);
DChromeavg = zeros(6,6);
% ---------Calculate the average matrix---------

% for i = 1:25:150
%     for j = 1:25:150
%         i_ = fix(i/25);
%         j_ = fix(j/25);
%         DMFCCavg(i_+1,j_+1) = mean(mean(MfccD(i:i+24,j:j+24)))/625;
%         DChromeavg(i_+1,j_+1) = mean(mean(chromeD(i:i+24,j:j+24)))/625;
%     end
% end

%gcf get current figure
% figure
% colormap jet
% imagesc(DChromeavg);
% title(strcat('Chrome average dis Number of Sec',{' '},int2str(NumSec)));
% colorbar
% saveas(gcf,strcat('Chrome_average_dis NumSec',int2str(NumSec),'.png'));
% 
% figure
% colormap jet
% imagesc(DMFCCavg);
% title(strcat('MFCC average Number of Sec',{' '},int2str(NumSec)));
% colorbar
% saveas(gcf,strcat('MFCC_average NumSec',int2str(NumSec),'.png'));
% 
% figure
% colormap jet
% colorbar
% imagesc(MfccD)
% title(strcat('MFC distance Number of Sec',{' '},int2str(NumSec)));
% saveas(gcf,strcat('MFC_distance NumSec',int2str(NumSec),'.png'));
% 
% 
% 
% figure
% colormap jet
% colorbar
% imagesc(chromeD);
% title(strcat('chrome distance Number of Sec',{' '},int2str(NumSec)));
% saveas(gcf,strcat('chromedistance',int2str(NumSec),'.png'));

% Assignment
% 8. Implement a classifier based on the following ingredients, as explained above,
% � computation of the 12 mfcc coefficients, or 12 Normalized Pitch Class Profile
% � modified Kullback-Leibler distance d defined by (6)
% � genre = majority vote among the 5 nearest neighbors
ConfusionMatrix = zeros(6,6);
    for i = 1:6 %rows are the true genres
   % columns are the genres classified by my algorithm
     ConfusionMatrix(i,:) = Classifier(chromeD,i);
    end
    Accuracy = ConfusionMatrix/25;
%------------End of problem 8-----------------

% 9. Using cross validation, as explained in section 5.2, evaluate your classification algorithm. You
% will compute the mean and standard deviation for all the entries in the confusion matrices.
%Cross validation of the algorithm:


p = zeros(6,25);
total = zeros(6,6);
% create cell array for average and standard deviation
RecordMatrix = zeros(10,6);
for n = 1:10 % start of repeat
%     -----------------Version 1--------------------%
    % pass in the 5-fold cross validation
    TestSong = zeros(6,5);
    TrainSong = zeros(6,20);
%     for k = 1:5
        for g = 1:6 %form a set of test songs and training songs
            p(g,:) = randperm(25)+25*(g-1);
            TestSong(g,:) = p(g,1:5);
%             TrainSong(g,:) = p(g,6:25);
        end
        %Since we have the distance song already,set all the 
        %test song value to zeros
        i = 1;
        indices = zeros(1,30);
        %put all indices into a single row of matrix
        TestingSet = sort(reshape(TestSong,[1,30]));
        MfccD(TestingSet(1,1:30),TestingSet(1,1:30)) = 0;
        ConfusionCrossMatrix = zeros(6,6);
          for gen = 1:6
              ConfusionCrossMatrix(gen,:) = ClassifierCross(chromeD,p(gen,1:5));
          end
          total = ConfusionCrossMatrix + total;
          RecordMatrix(n,:) = reshape(diag(ConfusionCrossMatrix),1,6);
%           RecordMatrix{n} = ConfusionCrossMatrix;
end

% average = total/10;

%---------------------End of version 1----------------------------

averageMatirx = total/10;

average = zeros(1,6);
StandMatrix = zeros(1,6);
for a = 1:6
    average = mean(RecordMatrix)/5;
    StandMatrix = std(RecordMatrix);
end

%11. Improve the classifier using support vector machines (SVM).
%create a empty cell array
for i = 1:25
    classname{i} = 'Classical';
    classname{i+25} = 'Electronic';
    classname{i+50} = 'Jazz';
    classname{i+75} = 'metal';
    classname{i+100} = 'rock';
    classname{i+125} = 'World';
end

Mdl = fitcecoc(MfccD,classname);
%%
% Display the coding design matrix.
Mdl.ClassNames
CodingMat = Mdl.CodingMatrix
%% 
% A one-versus-one coding design on three classes yields three binary
% learners.  Columns of |CodingMat| correspond to learners and rows 
% correspond to classes.  The class order corresponds to the order
% in |Mdl.ClassNames|. For example, |CodingMat(:,1)| is |[1; -1; 0]|, and  
% indicates that the software trains the first SVM binary learner using
% all observations classified as |'setosa'| and |'versicolor'|.  Since
% |'setosa'| corresponds to |1|, it is the positive class, and since
% |'versicolor'| corresponds to |-1|, it is the negative class.
%%
% You can access each binary learner using cell indexing and dot notation.
for i = 1:6
    Mdl.BinaryLearners{i};                % The first binary learner
    Mdl.BinaryLearners{i}.SupportVectors % Support vector indices
end
%%
% Compute the in-sample classification error.
isLoss = resubLoss(Mdl)
%%
% The classification error is small, but the classifier might have been
% overfit.  You can cross validate the classifier using |crossval|.

toc