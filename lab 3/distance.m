function [d] = distance(mfcc1,mfcc2,gam)
    mu1 = mean(mfcc1,2);
    co1 = cov(mfcc1');
    mu2 = mean(mfcc2,2);
    co2 = cov(mfcc2');
    K = 12;
    iCo1 = pinv(co1);
    iCo2 = pinv(co2);
    KL = 0.5*trace(co1*iCo2) + trace(co2*iCo1) + trace(((mu1-mu2)'*(iCo1+iCo2)*(mu1-mu2)))-K;
    d = 1 - exp(-gam/(KL + eps));
end

