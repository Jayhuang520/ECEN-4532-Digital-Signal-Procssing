function [coeffMat,temp] = dctmgr(input_image)
%This is assignment 1:
%Write the MATLAB function dctmgr that implements the following functionality:
% (a) it takes an luminance (gray-level) image as an input, divides it into non overlapping 8  8
% blocks, and DCT transform each block according to (1).
% (b) The DCT coefficients for the entire image are returned into a matrix coeff of size
% 64  Nblocks, where Nblocks is the number of 8  8 blocks inside the image.
% (c) For a given block b, the coefficients of in the column coeff(:,b) are organized according
% to the zig-zag order shown in Fig. 3. That is,
% coeff(2,b) = F(1,2), coeff(3,b) = F(2,1), coeff(4,b) = F(3,1),...
% (d) The zero-frequency coefficients, F(1; 1), for each block is encoded using differential
% encoding,
% coeff(1,1) = F1(1; 1),
% coeff(1,2) = F2(1; 1) ? F1(1; 1),
% coeff(1,3) = F3(1; 1) ? F2(1; 1),
% ...
% where Fi(1; 1) is the zero frequency DCT coefficient of block i.
[y,x] = size(input_image);
index = 1;
coeffMat = zeros(64,y*8);
dctMatrix = zeros(y,x);
for yy = 1:8:y
    for xx = 1:8:x
        temp = input_image(yy:yy+7,xx:xx+7);
        dctMat = dct2(temp);
        dctMatrix(yy:yy+7,xx:xx+7) = dctMat;
        %The coefficient matrix:
        coeffMat(:,index) = ZigZag(dctMat);
        index = index + 1;        
    end
end
temp = coeffMat(1,:);
for i = 2:y*8
    coeffMat(1,i) = temp(1,i) - temp(1,i-1);
end

