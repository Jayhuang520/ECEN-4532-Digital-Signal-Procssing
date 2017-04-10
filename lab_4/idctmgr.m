function [ output_args ] = idctmgr(coeffMat )
%(a) It takes a matrix coeff of size 64  Nblocks, where Nblocks is the number of 8  8 blocks
% inside the image and reconstruct a luminance image.
% (b) For each given block b, the coefficients in the column coeff(:,b) are used to reconstruct
% the block according to (3).
[y,x] = size(coeffMat);
idctMat = zeros(8,8);
lossFactor = 100;
QuanTable = [16 11 10 16 24 40 51 61;
             12 12 14 19 26 58 60 55
             14 13 16 24 40 57 69 56
             14 17 22 29 51 87 80 62
             18 22 37 56 68 109 103 77
             24 35 55 64 81 104 113 92
             49 64 78 87 103 121 120 101
             72 92 95 98 112 100 103 99];
    for yy = 1:8:y
        for xx = 1:8:x
            idctMat = idct2(coeffMat)
        end
    end
end

