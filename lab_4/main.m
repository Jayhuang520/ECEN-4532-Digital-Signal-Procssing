
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
% % beginging of the first four parts:
% %      f = imread('clown.pgm');
%     f = imread(fileName(i).name);
%      figure,imagesc(f, [0 255]),colormap gray,axis square,axis off;
%      lossFactor = 20;
%      g = im2double(f);
%      [coeffMat,temp] = dctmgr(g,lossFactor);
%      outputImage = idctmgr(coeffMat,temp,lossFactor);
%  	outputImage = im2uint8(outputImage);
% 	figure,imagesc(outputImage, [0 255]),colormap gray,axis square,axis off;
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
PSNRMatrix = zeros(50,6);
% parfor i = 1:numImage
%     f = imread(fileName(i).name);
%     g = im2double(f);
%     
%     for lossFactor = 1:50
%         [coeffMat,temp] = dctmgr(g,lossFactor);
%         outputImage = idctmgr(coeffMat,temp,lossFactor);
%         outputImage = im2uint8(outputImage);
%         reconstructionError = f - outputImage;
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

%  Required fields in PARAMS:
%  --------------------------
%
%    'data' - Training data.
%      A matrix containing the training signals as its columns.
%
%    'Tdata' / 'Edata' - Sparse coding target.
%      Specifies the number of coefficients (Tdata) or the target error in
%      L2-norm (Edata) for coding each signal. If only one is present, that
%      value is used. If both are present, Tdata is used, unless the field
%      'codemode' is specified (below).
%
%    'initdict' / 'dictsize' - Initial dictionary / no. of atoms to train.
%      At least one of these two should be present in PARAMS.
%
%      'dictsize' specifies the number of dictionary atoms to train. If it
%      is specified without the parameter 'initdict', the dictionary is
%      initialized with dictsize randomly selected training signals.
%
%      'initdict' specifies the initial dictionary for the training. It
%      should be either a matrix of size NxL, where N=size(data,1), or an
%      index vector of length L, specifying the indices of the examples to
%      use as initial atoms. If 'dictsize' and 'initdict' are both present,
%      L must be >= dictsize, and in this case the dictionary is
%      initialized using the first dictsize columns from initdict. If only
%      'initdict' is specified, dictsize is set to L.
%30 dictionary atoms
output = zeros(10,4);
for i = 1:10
    field1 = 'data'; value1 = double(data100(:,:,i));
    field2 = 'Tdata'; value2 = 10;
    field3 = 'dictsize'; value3 = 30;
    A = struct(field1,value1,field2,value2,field3,value3);
    output(i) = ksvd(A)

end
toc