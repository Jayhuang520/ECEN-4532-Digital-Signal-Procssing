function [output] = iQuantization(Fuv,lossFactor,QuantizationTable)
%Inverse quantization:
output = zeros(8,8);
    for u = 1:8
        for v = 1:8
            output(u,v) = Fuv(u,v)*lossFactor*QuantizationTable(u,v);
        end
    end

end

