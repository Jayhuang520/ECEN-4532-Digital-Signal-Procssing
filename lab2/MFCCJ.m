function [mfcc] = MFCCJ(wav, fs, fftSize, window)
   %define Hopping size
   hop = fftSize/2;
   nbanks = 40; %% Number of Mel frequency bands
    % linear frequencies
    linFrq = 20:fs/2;
    LinerRange = linspace(0,fs/2,hop+1);
    
    % mel frequencies
    melFrq = log ( 1 + linFrq/700) *1127.01048;
    % equispaced mel indices
    melIdx = linspace(1,max(melFrq),nbanks+2);
    % From mel index to linear frequency
    melIdx2Frq = zeros (1,nbanks+2);
    % melIdx2Frq (p) = \Omega_p
    for i=1:nbanks+2
        [val indx] = min(abs(melFrq - melIdx(i)));
        melIdx2Frq(i) = linFrq(indx);
    end
    omegaL = melIdx(1:nbanks);
    omega =  melIdx(2:nbanks+1);
    omegaR = melIdx(3:nbanks+2);
    for i = 1:nbanks
        for j =1:257
            if(LinerRange(j) > omegaL(i)) && (LinerRange(j)<= omega(i))
                freqResponse(i,j) = 2./(omegaR(i)-omegaL(i)).*(LinerRange(j)-omegaL(i))/(omega(i)-omegaL(i));
            elseif (LinerRange(j) > omega(i)) && (LinerRange(j) < omegaR(i))
                freqResponse(i,j) = 2./(omegaR(i)-omegaL(i)).*(omegaR(i)-LinerRange(j))/(omegaR(i)-omega(i));
            end
        end
    end
    semilogx(freqResponse);
end