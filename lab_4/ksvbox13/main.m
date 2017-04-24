clear all;close all;clc;
tic
load('usps_all.mat');
data100 = data(:,1:100,:);
output = zeros(10,4);
for i = 1:10
    field1 = 'data'; value1 = double(data100(:,:,i));
    field2 = 'Tdata'; value2 = 10;
    field3 = 'dictsize'; value3 = 30;
    A = struct(field1,value1,field2,value2,field3,value3);
    output(i) = ksvd(A);

end
toc