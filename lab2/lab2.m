%This is Lab 2 of Digital Signal Processing
clear all;close all;clc;
% pathName = 'C:\Users\JayHuang\Documents\GitHub\ECEN4532-Digital-Signal-Procssing\lab2';
% fileList = dir(fullfile(pathName,'*.wav'));
% fileName = dir('*.wav');
% NumSong = size(fileName,1);
% 
fftSize = 512;
kw = kaiser(fftSize);
[song,fs] = audioread('track201-classical.wav');
ExtractedSong = SongExtract(song,24,fs);
mfccCoe = mfcc(ExtractedSong,fs,fftSize,kw);
nf = floor(24*fs/(fftSize/2));
mfcc = zeros(40,nf);
for n = 1:256:(nf-1)*256
    mfcc(:,index) = mfcc(ExtractedSong(n:n+fftSize-1),fs,fftSize,kw);
    index = index + 1;
end

mfcc = 10*log10(mfcc);