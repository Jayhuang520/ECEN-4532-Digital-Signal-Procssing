function [ ] = idctmgr(coeffMatrix,temp)
%(a) It takes a matrix coeff of size 64  Nblocks, where Nblocks is the number of 8  8 blocks
% inside the image and reconstruct a luminance image.
% (b) For each given block b, the coefficients in the column coeff(:,b) are used to reconstruct
% the block according to (3).
[y,x] = size(coeffMatrix);
idctMat = zeros(512,512);
lossFactor = 100;

coeffMatrix(1,:) = temp;
         for yy = 1:8:512
             for xx = 1:8:512
                 tempMat = InverseZigZag(coeffMatrix(yy:yy+7,xx:xx+7));
                 
             end
         end
end

