
%This is lab 4 for ECEN 4532 Digital Signal Processing Lab:
%This is the main script for lab 4
clear all;close all;clc;
tic
pathName = 'C:\Users\JayHuang\Documents\GitHub\ECEN-4532-Digital-Signal-Procssing\lab_4\images\images';
fileList = dir(fullfile(pathName,'*.pgm'));
fileName = dir('*.pgm');
numImage = size(fileName,1);
% 
for i = 1:numImage
beginging of the first four parts:
     f = imread('clown.pgm');
    f = imread(fileName(i).name);
     figure,imagesc(f, [0 255]),colormap gray,axis square,axis off;
     lossFactor = 20;
     g = im2double(f);
     [coeffMat,temp] = dctmgr(g,lossFactor);
     outputImage = idctmgr(coeffMat,temp,lossFactor);
 	outputImage = im2uint8(outputImage);
	figure,imagesc(outputImage, [0 255]),colormap gray,axis square,axis off;

    reconstructionError = f - outputImage;

    
%     figure,imagesc(outputImage, [0 255]),colormap gray,axis square,axis off;
%     title(strcat('Reconstructed Image with','LF',int2str(lossFactor)));
%     saveas(gcf,strcat('Image',int2str(i),' ','LF',int2str(lossFactor),'.png'));
%     
%     figure,imagesc(reconstructionError);
%     title(strcat('Reconstructed error with','LF',int2str(lossFactor)));
%     saveas(gcf,strcat('Image error',int2str(i),' ','LF',int2str(lossFactor),'.png'));
end
%----------------end of first four parts-----------------------

%---------------------part 5--------------------------------%
% 5. For the six test images, compute the Peak Signal to Noise Ratio (PSNR) between the original
PSNRMatrix = zeros(50,6);
parfor i = 1:numImage
    f = imread(fileName(i).name);
    g = im2double(f);
    
    for lossFactor = 1:50
        [coeffMat,temp] = dctmgr(g,lossFactor);
        outputImage = idctmgr(coeffMat,temp,lossFactor);
        outputImage = im2uint8(outputImage);
        reconstructionError = f - outputImage;
        [peaksnr,snr] = psnr(outputImage,f);
        PSNRMatrix(lossFactor,i) = peaksnr;
    end
end

% figure
% lossFactor = 1:50;
% fileName = {'barbara','clown','fingerprint','mandril','roof','straw'}
% for i = 1:6
%     subplot(2,3,i)
%     plot(lossFactor,PSNRMatrix(:,i)');
%     title(strcat(fileName(i),' ','PSNR'));
% end
% saveas(gcf,'LossFactorVSPSNR.png')

%-------------------End of part 5---------------------------------------

%-----------------------------Part II Sparse Representation Model---------
% 6. Choose the first 100 examples of each digit from the USPS data set. Run the K-SVD algorithm on
% the selected examples from all ten digits with parameters d = 30 and T = 10. Please visualize
% these 30 dictionary atoms and explain.

load('usps_all.mat');

%The array dimension is 256x1100x10
%256 means the image is 16x16
%1100 means there are 1100 samples of each digits
%10 means there are 10 digits (0-9)
%Since the image have been converted into column vectors

%grab the first 100 samples
data100 = data(:,1:100,:);

%30 dictionary atoms
d = 30;

T = 10;


toc