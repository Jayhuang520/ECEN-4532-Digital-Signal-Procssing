%This is Lab 2 of Digital Signal Processing
clear all;close all;clc;
tic
%------------Read in all the filename--------------------------
filename = {'track201-classical.wav','track204-classical.wav',...
'track370-electronic.wav','track396-electronic.wav',...
'track437-jazz.wav','track439-jazz.wav',...
'track463-metal.wav','track492-metal.wav',...
'track547-rock.wav','track550-rock.wav',...
'track707-world.wav','track729-world.wav'};
for fileIndex = 1:12
    [song,fs] = audioread(char(filename(fileIndex)));
    fftSize = 512;
    kw = kaiser(fftSize);
% %     [song,fs] = audioread('track396-electronic.wav');
    ExtractedSong = (SongExtract(song,24,fs));
    nf = floor(24*fs/(fftSize/2));
    mfcc1 = zeros(40,nf);
    index = 1;
    for n = 1:256:(nf-1)*256
        mfcc1(:,index) = mfcc(ExtractedSong(n:n+fftSize-1),fs,fftSize,kw);
        index = index + 1;
    end

    mfcc1 = 10*log10(mfcc1);
    sim = zeros(nf,nf);
    % 1. Implement the computation of the similarity matrix, and display the similarity matrices (color-coded)
    % for the 12 audio tracks supplied for the rst lab. See Fig. 1 for an example of a similarity matrix.
%     for i = 1:nf
%         for j = 1:nf
%             sim(i,j) = SimilarityMatrix(mfcc1,i,j);
%         end
%     end
%     figure
%     imagesc(sim)
%     title(filename(fileIndex));
%     colormap jet
%     colorbar
%     saveas(gcf,strcat('Similarity',int2str(fileIndex),'.png'));
    %---------------------end of problem 1---------------------------------

    %Implement the computation of the rhythm index B(l) dened in (4). Plot the vector B as a function
    % of the lag l = 0;Nf -1 for the 12 tracks. Comment on the presence, or absence, of a strong rhythmic
    % pattern.
    % Hint: to debug your function, you can use track-396 which should display strong rhythmic structure.
%     sumT = 0;
%     B = zeros(1,nf);
%     for l = 1:nf
%         for n = 1:nf-l
%             sumT = sumT + sim(n,n+l-1);
%         end
%         B(l) = 1/(nf-l-1)*(sumT);
%         sumT = 0;
%     end
%     figure
%     plot(B);
%     title(strcat('First Estimate for',{' '},filename(fileIndex)));
%     xlabel('lag(secs)')
%     %gcf stands for get current figure
%     saveas(gcf,strcat('FirstEst',int2str(fileIndex),'.png'));

    %--------------------End of problem 2------------------------------------
    % 3. Implement the computation of the rhythm index AR(l) dened in (6). Plot the vector AR as a function
    % of the lag l = 0;Nf -1 for the 12 tracks. Comment on the presence, or absence, of a strong rhythmic
    % pattern.
    % See Fig. 2 for an example of a plot of the rhythm index.
%     AR = zeros(1,nf-3);
%     for l = 1:nf-3
%         for i = 1:nf-1
%             for j = 1:nf-2-l
%                 product(i,j) = sim(i,j)*sim(i,j+l-1);
%             end
%         end
%         AR(l) = 1/(nf*(nf-l))*sum(sum(product(:,:)));
%         product(:,:) = 0;
%     end
%     figure
%     plot(AR)
%     title(strcat('A better Estimate for',{' '},filename(fileIndex)));
%     xlabel('lag(sec)')
%     saveas(gcf,strcat('BetterEst',int2str(fileIndex),'.png'));

    % 4. Implement the computation of the rhythm index AR(l;m) dened in (8). Plot the image AR in false
    % color as a function of the lag l = 0; : : : ; 19 (y-axis) and the time window index m (x-axis) for the 12
    % tracks. Comment on the variation of rhythm patterns for the dierent tracks.

%     ShortSong = (SongExtract(song,1,fs));
%     nfs = floor(1*fs/(fftSize/2));
%     mfcc2 = zeros(40,nfs);
%     index = 1;
%     for n = 1:256:(nfs-1)*256
%         mfcc2(:,index) = mfcc(ShortSong(n:n+fftSize-1),fs,fftSize,kw);
%         index = index + 1;
%     end
% 
%     Sim1sec = zeros(nfs,nfs);
% 
%     for i = 1:nfs
%         for j = 1:nfs
%             Sim1sec(i,j) = SimilarityMatrix(mfcc2,i,j);
%         end
%     end
% %     figure
% %     imagesc(Sim1sec)
% %     title('Similarity Matrix for 1 seconds')
% %     colormap jet 
% %     colorbar
% 
%     prod = zeros(20,20);
%     for l = 1:20
%         for m = 1:floor(nfs/20)-1
%             for i = 1:20
%                 for j = 1:20-l+1
%                     prod(i,j) = Sim1sec(i+m*20,j+m*20)*Sim1sec(i+m*20,j+m*20+l-1);
%                 end
%             end
%             ARlm(m,l) = 1/(20*(20-l))*sum(sum(prod(:,:)));
%             prod = 0;
%         end
%     end
%     figure
%     imagesc(ARlm);
%     title(strcat('AR on the variation of rhythm patterns for',{' '},filename(fileIndex)));
%     ylabel('lag(s)')
%     xlabel('times(s)')
%     color map
%     saveas(gcf,strcat('AR',int2str(fileIndex),'.png'));

    %-------------------------End of problem 4----------------------------
    % 5. Implement the computation of the Normalized Pitch Class Prole, dened by (18). You will compute
    % a vector of 12 entries for each frame n.
    % 6. Evaluate and plot the NPCP for the 12 audio tracks supplied for the rst lab.
    % See Fig. 4 for an example
    
    Threshold = max(max(song));
    index = 1;
    %Allocate a 12 by number of frames vector
    output = zeros(12,nf);
    %Passing each frame of the song into the NPCP funciotn
    for n = 1:fftSize/2:floor(length(ExtractedSong)-2048)
        output(:,index) = NPCP(ExtractedSong(n:n+fftSize-1),fs,fftSize,kw,Threshold);
        index = index + 1;
    end
    output = 10*log10(output/Threshold);
    figure
    imagesc(output);
    title(filename(fileIndex));
    set(gca,'YDir','normal');
    set(gca,'YTick',[1:12]);
    set(gca,'YTickLabel',({'A';'A#';'B';'C';'C#';'D';'D#';'E';'F';'F#';'G';'G#'}))
    xlabel('Second');
    ylabel('Note');
    colormap jet
    colorbar
    saveas(gcf,strcat('NPCP for',int2str(fileIndex),'.png'));
end
toc
