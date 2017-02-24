function [mfcc1] = Cov_Mu(mfcc)
%Merge the Mel bank to 12 bands
t = zeros(1,36);
t(1) = 1; t(7:8) = 5; t(15:18) = 9;
t(2) = 2; t(9:10) =6; t(19:23) = 10;
t(3:4)=3; t(11:12)=7; t(24:29) = 11;
t(5:6)=4; t(13:14)=8; t(30:36) = 12;
mel2 = zeros(12,size(mfcc,2));
    for i = 1:12
        mel2(i,:) = sum(mfcc(t==i,:),1);
    end
    len = size(mel2,2);
    mfcc1 = mel2(:,1:len-1);
end

