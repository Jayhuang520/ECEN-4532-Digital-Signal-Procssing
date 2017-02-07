function [ output ] = FFTSquare( wav,fftsize,window)
%     xn = wav(1:fftsize);
    Y = fft(window.*wav);
    K = fftsize/2+1;
    Xn = Y(1:K);
    output = (abs(Xn)).^2;
    
end

