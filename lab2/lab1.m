clc;clear;close all
filename = {'track201-classical.wav','track204-classical.wav',...
'track370-electronic.wav','track396-electronic.wav',...
'track437-jazz.wav','track439-jazz.wav',...
'track463-metal.wav','track492-metal.wav',...
'track547-rock.wav','track550-rock.wav',...
'track707-world.wav','track729-world.wav'};
for fileIndex = 1:12
[song,fs] = audioread(char(filename(fileIndex)));
%%%% audio files are sampled at fs = 11025 Hz
    fftsize = 512;
    loudness = zeros(1,516);
    ZCR = zeros(1,516);
    % 2.Write a MATLAB function that extract T seconds of music from a given track. You
    %will use the MATLAB function waveread to read a track and the function play to
    %listen to the track.
    %In the lab you will use T =24 seconds from the middle of each track to compare the
    %di?erent algorithms. Download the ?les, and test your function.

%     [song,fs] = audioread('track201-classical.wav');
    %---function to extract the song-----------
    ExtractedSong = SongExtract(song,24,fs);
    %-----------------------------End of problem 2-------------------------
    %3.Implement the loudness and ZCR and evaluate these features on the di?erent music
    %tracks. Your MATLAB function should display each feature as a time series in a separate
    %fgure (see e.g. Fig. 1).

    for n = 1:size(ExtractedSong)/fftsize 
        loudness(n) = std(song);
        m = n + 1;
        ZCR(n) = ZeroCrossing(ExtractedSong,m,fftsize);
    end

    %---------------------------End of problem 3----------------------------

%     t = 1:516;
%     figure
%     plot(t,ZCR);
%     title('Zero crossing rate as a function of the frame number');
%     xlabel('Frames number')
%     ylabel('Zero Crossing Rate')
    %------need to implement a display each feature

    %4.Comment on the speci?city of the feature, and its ability to separate di?erent musical
    %genre.

    %problem 5 and problem 6 are done elsewhere

    %7. Implement the computation of the windowed Fourier transform of y, given by (3).
    % Evaluate its performance with pure sinusoidal signals and di?erent windows:
    % • Bartlett
    % • Hann
    % • Kaiser,

%     BartlettWindow = bartlett(fftsize);
%     HannWindow = hann(fftsize);
%     KaiserWindow = kaiser(fftsize);
% 
%     PureSig = 1:fftsize;
%     PureSin = sin(PureSig);
%     BartlettOutput = fftWindow(PureSin,fftsize,BartlettWindow);
%     HannOutput = fftWindow(PureSin,fftsize,HannWindow);
%     KaiserOutput = fftWindow(PureSin,fftsize,KaiserWindow);
%     figure
%     plot(abs(BartlettOutput));
%     title('Output of Bartlett window')
%     xlabel('Frames')
%     ylabel('Frequency response')
%     
%     figure
%     plot(abs(HannOutput));
%     title('Output of Hann window')
%     xlabel('Frames')
%     ylabel('Frequency response')
%     
%     
%     figure
%     plot(abs(KaiserOutput));
%     title('Output of Kaiser window')
%     xlabel('Frames')
%     ylabel('Frequency response')
    
    %---------------------------End of problem 7------------------------------
    % 8. Compute the spectrogram of an audio track as follows:
    % (a) Decompose a track into a sequence of Nf overlapping frames of size N. The
    % overlap between two frames should be N/2.
    % (b) Compute the magnitude squared of the Fourier transform, |X(k)|2, k = 1, . . . ,K
    % over each frame n.
    % (c) Display the Fourier transform of all the frames in a matrix of size K ? Nf . The
    % spectrogram should look like Fig. 2.
    % You will experiment with di?erent audio tracks, as well as pure sinusoidal tones. Do
    % the spectrograms look like what you hear?

    %Calculation of number of frames
    kwindow = kaiser(fftsize);
    nf = floor(24*fs/(fftsize/2));
    output7 = zeros(257,nf);
    index = 1;
    Xhat = zeros(512,1032);

    %There is always two extra frame
    %Allocate memory for the output
    for n = 1:fftsize/2:((nf-2)*256)
        Xhat(:,index) = FreqDist(ExtractedSong(n:n+fftsize-1));
       output7(:,index) = FFTSquare(ExtractedSong(n:n+fftsize-1),fftsize,kwindow);
       %Implement question 9

       %------------Spectral centroid and spread------------------------------
       %The spectral centroid E[cXn] can be used to quantify sound sharpness 
       %or brightness.
        E(:,index) = 1/(fftsize/2)*mean(Xhat(:,index));
        STD(:,index) = std(Xhat(:,index));

       %--------------end of spectral centroid and spread-------------------
       %Spectral flatness
       output9(:,index) = SpectralFlatness((output7(:,index)).^(1/2),fftsize/2);

       %----------------------------Spectral flux--------------------------
    %The spectral ?ux is a global measure of the spectral changes between two 
    %adjacent frames, n?1 and n,
        Fn(:,index) = sum((Xhat(:,index)-Xhat(:,index+1)).^2);

       index = index + 1;
    end
    %Display the output
    output7 = 20*log10(output7);

%     figure
%     imagesc(output7)
%     title('Spectrogram')
%     ylabel('Fourier Transform')
%     xlabel('frame number')
%     colormap jet
%     colorbar
% 
%     figure
%     plot(output9)
%     title('Spectral flatness as a function of the Frame number')
%     ylabel('flatness')
%     xlabel('frame number')

    %-----------------------End of problem 8-----------------------------

    %----------------------Problem 9---------------------------------------
    % 9. Implement all the low level spectral features and evaluate them on the di?erent tracks.
    % Your MATLAB function should display each feature as a time series in separate ?gure
    % (e.g. see Fig. 3).


    % 11. Implement the computation of the triangular ?lterbanks Hp, p = 1, . . . ,NB. Your
    % function will return an array fbank of size NB?K such that fbank(p,:) contains
    % the ?lter bank Hp.
    %--------------------Implementation of problem 11--------------------
    for n = 1:256:(nf-1)*256
        output11(:,index) = mfcc(ExtractedSong(n:n+fftsize-1),fs,fftsize,kwindow);
        index = index + 1;
    end
    output = 20*log10(output11);
    figure
    imagesc(output);
    title(filename(fileIndex));
    set(gca,'YDir','normal');
    xlabel('Frames');
    ylabel('Filter Bank');
    colormap jet
    colorbar
end