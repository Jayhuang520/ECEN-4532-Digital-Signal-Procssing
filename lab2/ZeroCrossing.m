function [ output ] = ZeroCrossing(wav,n,fftsize)
%Implement the zeros corssing of the signal
temp = zeros(fftsize,1);
    for m = 1:fftsize
        temp(m,1) = abs(sign(wav(n+m))-sign(wav(n+m-1)));
    end
    output = 1/(2*fftsize)*sum(temp);
end

