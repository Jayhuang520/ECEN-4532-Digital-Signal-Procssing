function [score] = Corr(x,y)
%Success in this lab will be measured as the correlation between the true
%ratings and your predicted rating for these 5 features(Amusement,Attentio
%Environmental sounds, Language, Motion)
    xbar = mean(x);
    ybar = mean(y);
    xdiff = x - xbar;
    ydiff = y - ybar;
    score = sum(xdiff.*ydiff)/sqrt((sum(xdiff.^2))*(sum(ydiff.^2)));

end

