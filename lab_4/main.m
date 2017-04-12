%This is lab 4 for ECEN 4532 Digital Signal Processing Lab:
%This is the main script for lab 4
clear all;close all;clc;

pathName = 'C:\Users\JayHuang\Documents\GitHub\ECEN-4532-Digital-Signal-Procssing\lab_4\images\images';
fileList = dir(fullfile(pathName,'*.pgm'));
fileName = dir('*.pgm');

f = imread('clown.pgm');
%figure,imagesc(f, [0 255]),colormap gray,axis square,axis off;
g = im2double(f);
[coeffMat,temp] = dctmgr(g);

QuanTable = [16 11 10 16 24 40 51 61;
             12 12 14 19 26 58 60 55
             14 13 16 24 40 57 69 56
             14 17 22 29 51 87 80 62
             18 22 37 56 68 109 103 77
             24 35 55 64 81 104 113 92
             49 64 78 87 103 121 120 101
             72 92 95 98 112 100 103 99];


