
%This is lab 4 for ECEN 4532 Digital Signal Processing Lab:
%This is the main script for lab 4
clear all;close all;clc;
tic
pathName = 'C:\Users\JayHuang\Documents\GitHub\ECEN-4532-Digital-Signal-Procssing\lab_4\images\images';
fileList = dir(fullfile(pathName,'*.pgm'));
fileName = dir('*.pgm');
numImage = size(fileName,1);
% 
% for i = 1:numImage
% beginging of the first four parts:
     f = imread('clown.pgm');
%     f = imread(fileName(i).name);
     figure,imagesc(f, [0 255]),colormap gray,axis square,axis off;
     lossFactor = 20;
     g = im2double(f);
     [coeffMat,temp] = dctmgr(g,lossFactor);
     outputImage = idctmgr(coeffMat,temp,lossFactor);
 	outputImage = im2uint8(outputImage);
	figure,imagesc(outputImage, [0 255]),colormap gray,axis square,axis off;
% 
%     reconstructionError = f - outputImage;

    
%     figure,imagesc(outputImage, [0 255]),colormap gray,axis square,axis off;
%     title(strcat('Reconstructed Image with','LF',int2str(lossFactor)));
%     saveas(gcf,strcat('Image',int2str(i),' ','LF',int2str(lossFactor),'.png'));
%     
%     figure,imagesc(reconstructionError);
%     title(strcat('Reconstructed error with','LF',int2str(lossFactor)));
%     saveas(gcf,strcat('Image error',int2str(i),' ','LF',int2str(lossFactor),'.png'));
% end
%----------------end of first four parts-----------------------

%---------------------part 5--------------------------------%
% 5. For the six test images, compute the Peak Signal to Noise Ratio (PSNR) between the original
% PSNRMatrix = zeros(50,6);
% parfor i = 1:numImage
%     f = imread(fileName(i).name);
%     g = im2double(f);
%     
%     for lossFactor = 1:50
%         [coeffMat,temp] = dctmgr(g,lossFactor);
%         outputImage = idctmgr(coeffMat,temp,lossFactor);
%         outputImage = im2uint8(outputImage);
%         reconstructionError = f - outputImage;
% %         PSNRMatrix(lossFactor,i) = PSNR(reconstructionError);
%         [peaksnr,snr] = psnr(outputImage,f);
%         PSNRMatrix(lossFactor,i) = peaksnr;
%     end
% end

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


toc