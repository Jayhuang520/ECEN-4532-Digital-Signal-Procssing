%This file is created by Zhi Jie Huang
%This is the lab 5 Mind-Reading from fMRI Data
%Goal:*Accurate prediction of 5 “time series” representing human subject ratings of 
% the extent to which each of 5 people, places, things, or moods were present in the 
% video at each instant in time.  
clc;close all;clear all;
tic
lab5data = importdata('lab5_data.mat');
%ROI(region of interest)
% 1.  The matrix ROIsLH_new: This is a 800x149 matrix in which the (k, l) entry 
% represents the activity level in ROI $ of the left hemisphere of the subject’s 
% brain at time instant ".  
% 2.  The matrix ROIsRH_new: This is a 800x152 matrix in which the (k, l) entry 
% represents  the  activity  level  in  ROI  l  of  the  right  hemisphere  of  the 
% subject’s brain at time instant ".  
% 3.  The matrix Ratings_new: This  is a 800x5 matrix  containing  the  feature 
% ratings  of  the  5  features  that  are  given  in  the  list  above. Hence,  each 
% matrix  entry  (k, l)  represents  the  subject’s  rating  of  feature  k  at  time 
% instant ".
% Divide the 800 into 4 dataset, use three subset for training, use 1 for testing. 
% Doing it 4 times to measure the accuracy of the algorithm
[yLH,xLH] = size(lab5data.ROIsLH_new);
[yRH,xRH] = size(lab5data.ROIsRH_new);
[yR,xR] = size(lab5data.Ratings_new);
Y = lab5data.Ratings_new;

A = horzcat(lab5data.ROIsLH_new,lab5data.ROIsRH_new);
W = zeros(xLH+xRH,5);
Wnonlinear = zeros(4*(xLH+xRH),5);
predict = zeros(200,5);
trainingData = zeros(600,xLH+xRH);
Wcell = cell(4,100);
PredictCell = cell(4,100);
score = zeros(4,5);
standardDeviation = zeros(50,5);
averageScore = zeros(50,5);
%pass 4 fold cross validation

% for lamda = 1:50
for n = 1:4
    index = randperm(800);
    trainingIndex = index(1:600);
    testingIndex = index(601:800);
    trainingData = A(trainingIndex(:),:);
    testingData = A(testingIndex(:),:);
    Solution = Y(testingIndex(:),:);
    
%---------------nonlinearization------------
%    xsquare = trainingData.^2;
%    xcubic = trainingData.^3;
%    ONE = ones(600,301);
%    train = horzcat(xcubic,xsquare,trainingData,ONE);
%    
%    xsquare = testingData.^2;
%    xcubic = testingData.^3;
%    TWO = ones(200,301);
%    test = horzcat(xcubic,xsquare,testingData,TWO);
%----------end of nonlinearization-----------
    for feature = 1:5
        W(:,feature) = linearRegression(trainingData,Y(trainingIndex(:),feature));
%        W(:,feature) = Regularization(trainingData,Y(trainingIndex(:),feature),10);
%         Wnonlinear(:,feature) = NonlinearRegression(train,Y(trainingIndex(:),feature),10);
        predict(:,feature) = testingData*W(:,feature);
        score(n,feature) = Corr(predict(:,feature),Solution(:,feature));
    end
    Wcell{n,1} = W;
    PredictCell{n,1} = predict;
end
averageScore(1,:) = mean(score);
standardDeviation(1,:) = std(score);

% end

% figure
% for i = 1:5
%    subplot(3,2,i)
%    plot(averageScore(:,i));
%    title(lab5data.Ratings_featurenames(i));
% end

toc