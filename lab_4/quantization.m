function [output] = quantization(Fuv,lossFactor,QuantizationTable)
%Implement the quantizer
output = zeros(8,8);
    for u = 1:8
        for v = 1:8
            output(u,v) = round(Fuv(u,v)/(lossFactor*QuantizationTable(u,v)));
        end
    end
end

