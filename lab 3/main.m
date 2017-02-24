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
NumSec = 240;

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

DMFCCavg = zeros(6,6);
DChromeavg = zeros(6,6);
%---------Calculate the average matrix---------

for i = 1:25:150
    for j = 1:25:150
        i_ = fix(i/25);
        j_ = fix(j/25);
        DMFCCavg(i_+1,j_+1) = mean(mean(MfccD(i:i+24,j:j+24)))/625;
        DChromeavg(i_+1,j_+1) = mean(mean(chromeD(i:i+24,j:j+24)))/625;
    end
end

%gcf get current figure
figure
colormap jet
imagesc(DChromeavg);
title(strcat('Chrome average dis Number of Sec',{' '},int2str(NumSec)));
colorbar
saveas(gcf,strcat('Chrome_average_dis NumSec',int2str(NumSec),'.png'));

figure
colormap jet
imagesc(DMFCCavg);
title(strcat('MFCC average Number of Sec',{' '},int2str(NumSec)));
colorbar
saveas(gcf,strcat('MFCC_average NumSec',int2str(NumSec),'.png'));

figure
colormap jet
colorbar
imagesc(MfccD)
title(strcat('MFC distance Number of Sec',{' '},int2str(NumSec)));
saveas(gcf,strcat('MFC_distance NumSec',int2str(NumSec),'.png'));



figure
colormap jet
colorbar
imagesc(chromeD);
title(strcat('chrome distance Number of Sec',{' '},int2str(NumSec)));
saveas(gcf,strcat('chromedistance',int2str(NumSec),'.png'));

toc