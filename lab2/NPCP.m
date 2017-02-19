function [ output ] = NPCP( wav,fs,fftSize,window,Threshold)
        %
        % PART 2 : processing of the audio vector In the Fourier domain.
        %_________________________________________________________
        %
        Y = fft(wav.*window);
        K = fftSize/2+1;
        % L = K-1;
        Xn = abs(Y(1:K));
        %-------------Plot of the fourier transform--------------------------
        % f = fs*(0:L)/L;
        % plot(f,Xn);
        %--------Step 1 pick out the peak frequencies-------
        f0 = 27.5;
        %------Goal of the threshold:Get rid of the small amplitude note----
        [pkt,fk] = findpeaks(Xn,'Threshold',Threshold*1e-6);
        % [pkt,fk] = findpeaks(Xn,'NPeaks',20);
        FK = round(fk*fs/fftSize);
        %---------Step 2: Assignment of peak frequencies to
        %-----------------------------semitones-------------------------
        sm = round(12*log2(FK/f0));
        c = mod(sm,12)+1;
        r = 12*log2(FK/f0)-sm;
        output = zeros(12,1);
        for j = 1:12
            var = ismember(c,j);
            w = (cos(pi/2*r)).^2;
            output(j,1) = sum(var.*(w.*pkt.^2));
        end
    end


