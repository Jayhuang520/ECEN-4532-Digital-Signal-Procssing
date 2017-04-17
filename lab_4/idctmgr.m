function [output] = idctmgr(coeffMatrix,temp,lossFactor)
%(a) It takes a matrix coeff of size 64  Nblocks, where Nblocks is the number of 8  8 blocks
% inside the image and reconstruct a luminance image.
% (b) For each given block b, the coefficients in the column coeff(:,b) are used to reconstruct
% the block according to (3).
idctMat = zeros(8,8);
output = zeros(512,512);
[y,x] = size(coeffMatrix);
coeffMatrix(1,:) = temp;
index = 1;
%---------------Test for idct without quantization------------------
%          for yy = 1:8:505
%              for xx = 1:8:505
%                  idctMat = InverseZigZag(coeffMatrix(:,index));
%                  output(yy:yy+7,xx:xx+7) = idct2(idctMat);
%                  index = index + 1; 
%              end
%          end
%----------   End of testing idct quantization----------------


         for yy = 1:8:505
             for xx = 1:8:505
                 idctMat = InverseZigZag(coeffMatrix(:,index));
                 idctMat = iQuantization(idctMat,lossFactor);
                 output(yy:yy+7,xx:xx+7) = idct2(idctMat);
                 index = index + 1; 
             end
         end

end

