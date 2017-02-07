function [ output] = fftWindow(wav,fftsize,window)
    Y = fft(window.*wav);
    K = fftsize/2+1;
    output = Y(1:K);
end

