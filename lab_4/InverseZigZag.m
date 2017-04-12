function [ outputMatrix ] = InverseZigZag(InputMatrix)
%hard coded the inverse ZigZag
% 2. Write the MATLAB function idctmgr that implements the following functionality:
% (a) It takes a matrix coeff of size 64  Nblocks, where Nblocks is the number of 8  8 blocks
% inside the image and reconstruct a luminance image.
% (b) For each given block b, the coefficients in the column coeff(:,b) are used to reconstruct
% the block according to (3).
outputMatrix(1,1) = InputMatrix(1);
outputMatrix(1,2) = InputMatrix(2);
outputMatrix(2,1) = InputMatrix(3);
outputMatrix(3,1) = InputMatrix(4);
outputMatrix(2,2) = InputMatrix(5);
outputMatrix(1,3) = InputMatrix(6);
outputMatrix(1,4) = InputMatrix(7);
outputMatrix(2,3) = InputMatrix(8);
outputMatrix(3,2) = InputMatrix(9);
outputMatrix(4,1) = InputMatrix(10);
outputMatrix(5,1) = InputMatrix(11);
outputMatrix(4,2) = InputMatrix(12);
outputMatrix(3,3) = InputMatrix(13);
outputMatrix(2,4) = InputMatrix(14);
outputMatrix(1,5) = InputMatrix(15);
outputMatrix(1,6) = InputMatrix(16);
outputMatrix(2,5) = InputMatrix(17);
outputMatrix(3,4) = InputMatrix(18);
outputMatrix(4,3) = InputMatrix(19);
outputMatrix(5,2) = InputMatrix(20);
outputMatrix(6,1) = InputMatrix(21);
outputMatrix(7,1) = InputMatrix(22);
outputMatrix(6,2) = InputMatrix(23);
outputMatrix(5,3) = InputMatrix(24);
outputMatrix(4,4) = InputMatrix(25);
outputMatrix(3,5) = InputMatrix(26);
outputMatrix(2,6) = InputMatrix(27);
outputMatrix(1,7) = InputMatrix(28);
outputMatrix(1,8) = InputMatrix(29);
outputMatrix(2,7) = InputMatrix(30);
outputMatrix(3,6) = InputMatrix(31);
outputMatrix(4,5) = InputMatrix(32);
outputMatrix(5,4) = InputMatrix(33);
outputMatrix(6,3) = InputMatrix(34);
outputMatrix(7,2) = InputMatrix(35);
outputMatrix(8,1) = InputMatrix(36);
outputMatrix(8,2) = InputMatrix(37);
outputMatrix(7,3) = InputMatrix(38);
outputMatrix(6,4) = InputMatrix(39);
outputMatrix(5,5) = InputMatrix(40);
outputMatrix(4,6) = InputMatrix(41);
outputMatrix(3,7) = InputMatrix(42);
outputMatrix(2,8) = InputMatrix(43);
outputMatrix(3,8) = InputMatrix(44);
outputMatrix(4,7) = InputMatrix(45);
outputMatrix(5,6) = InputMatrix(46);
outputMatrix(6,5) = InputMatrix(47);
outputMatrix(7,4) = InputMatrix(48);
outputMatrix(8,3) = InputMatrix(49);
outputMatrix(8,4) = InputMatrix(50);
outputMatrix(7,5) = InputMatrix(51);
outputMatrix(6,6) = InputMatrix(52);
outputMatrix(5,7) = InputMatrix(53);
outputMatrix(4,8) = InputMatrix(54);
outputMatrix(5,8) = InputMatrix(55);
outputMatrix(6,7) = InputMatrix(56);
outputMatrix(7,6) = InputMatrix(57);
outputMatrix(8,5) = InputMatrix(58);
outputMatrix(8,6) = InputMatrix(59);
outputMatrix(7,7) = InputMatrix(60);
outputMatrix(6,8) = InputMatrix(61);
outputMatrix(7,8) = InputMatrix(62);
outputMatrix(8,7) = InputMatrix(63);
outputMatrix(8,8) = InputMatrix(64);
end

