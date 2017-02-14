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
% [song,fs] = audioread('track201-classical.wav');
ExtractedSong = (SongExtract(song,24,fs));
nf = floor(24*fs/(fftSize/2));
mfcc1 = zeros(40,nf);
index = 1;
for n = 1:256:(nf-1)*256
    mfcc1(:,index) = mfcc(ExtractedSong(n:n+fftSize-1),fs,fftSize,kw);
    index = index + 1;
end

% mfcc1 = 10*log10(mfcc1);
sim = zeros(nf,nf);
% 1. Implement the computation of the similarity matrix, and display the similarity matrices (color-coded)
% for the 12 audio tracks supplied for the rst lab. See Fig. 1 for an example of a similarity matrix.
for i = 1:nf
    for j = 1:nf
        sim(i,j) = mfcc1(:,i)'*mfcc1(:,j)/(norm(mfcc1(:,i))*norm(mfcc1(:,j)));
    end
end
% figure
% imagesc(sim)
% title('Similarity Matrix')
% colormap jet
% colorbar
%---------------------end of problem 1---------------------------------

%Implement the computation of the rhythm index B(l) dened in (4). Plot the vector B as a function
% of the lag l = 0;Nf -1 for the 12 tracks. Comment on the presence, or absence, of a strong rhythmic
% pattern.
% Hint: to debug your function, you can use track-396 which should display strong rhythmic structure.
sumT = 0;
B = zeros(1,nf);
for l = 1:nf
    for n = 1:nf-l
        sumT = sumT + sim(n,n+l-1);
    end
    B(l) = 1/(nf-l-1)*(sumT);
    sumT = 0;
end
figure
plot(B);
title('A first estimate of the Rhythm')

%--------------------End of problem 2------------------------------------
% 3. Implement the computation of the rhythm index AR(l) dened in (6). Plot the vector AR as a function
% of the lag l = 0;Nf -1 for the 12 tracks. Comment on the presence, or absence, of a strong rhythmic
% pattern.
% See Fig. 2 for an example of a plot of the rhythm index.
AR = zeros(1,nf);
for l = 1:nf
    for i = 1:nf
        for j = 1:nf-1
            AR(l) = 1/(nf*(nf-l))*sim(i,j)*sim(i,j+l-1);
        end
    end
end


