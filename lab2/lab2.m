%This is Lab 2 of Digital Signal Processing
clear all;close all;clc;
% pathName = 'C:\Users\JayHuang\Documents\GitHub\ECEN4532-Digital-Signal-Procssing\lab2';
% fileList = dir(fullfile(pathName,'*.wav'));
% fileName = dir('*.wav');
% NumSong = size(fileName,1);
% 

fftSize = 512;
kw = kaiser(fftSize);
[song,fs] = audioread('track437-jazz.wav');
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
% for i = 1:nf
%     for j = 1:nf
%         sim(i,j) = SimilarityMatrix(mfcc1,i,j);
%     end
% end
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
% sumT = 0;
% B = zeros(1,nf);
% for l = 1:nf
%     for n = 1:nf-l
%         sumT = sumT + sim(n,n+l-1);
%     end
%     B(l) = 1/(nf-l-1)*(sumT);
%     sumT = 0;
% end
% figure
% plot(B);
% title('A first estimate of the Rhythm')

%--------------------End of problem 2------------------------------------
% 3. Implement the computation of the rhythm index AR(l) dened in (6). Plot the vector AR as a function
% of the lag l = 0;Nf -1 for the 12 tracks. Comment on the presence, or absence, of a strong rhythmic
% pattern.
% See Fig. 2 for an example of a plot of the rhythm index.
% AR = zeros(1,nf-3);
% for l = 1:nf-3
%     for i = 1:nf-1
%         for j = 1:nf-2-l
%             product(i,j) = sim(i,j)*sim(i,j+l-1);
%         end
%     end
%     AR(l) = 1/(nf*(nf-l))*sum(sum(product(:,:)));
%     product(:,:) = 0;
% end
% figure
% plot(AR)
% title('A better estimate of Rhythm')

% 4. Implement the computation of the rhythm index AR(l;m) dened in (8). Plot the image AR in false
% color as a function of the lag l = 0; : : : ; 19 (y-axis) and the time window index m (x-axis) for the 12
% tracks. Comment on the variation of rhythm patterns for the dierent tracks.

ShortSong = (SongExtract(song,1,fs));
nfs = floor(1*fs/(fftSize/2));
mfcc2 = zeros(40,nfs);
index = 1;
for n = 1:256:(nfs-1)*256
    mfcc2(:,index) = mfcc(ShortSong(n:n+fftSize-1),fs,fftSize,kw);
    index = index + 1;
end

Sim1sec = zeros(nfs,nfs);

for i = 1:nfs
    for j = 1:nfs
        Sim1sec(i,j) = SimilarityMatrix(mfcc2,i,j);
    end
end
% figure
% imagesc(Sim1sec)
% title('Similarity Matrix for 1 seconds')
% colormap jet 
% colorbar
prod = zeros(20,20);
for m = 1:floor(nfs/20)-1
    for l = 1:20
        for i = 1:20
            for j = 1:20-l+1
                prod(i,j) = Sim1sec(i+m*20,j+m*20)*Sim1sec(i+m*20,j+m*20+l-1);
            end
        end
        ARlm(m,l) = 1/(20*(20-l))*sum(sum(prod(:,:)));
        prod = 0;
    end
end
figure
imagesc(ARlm);
title('AR on the variation of rhythm patterns')
color map
color bar

