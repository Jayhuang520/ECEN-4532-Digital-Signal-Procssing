function [ output ] = FreqDist( input )
    output = abs(input)/(sum(abs(input)));
end

