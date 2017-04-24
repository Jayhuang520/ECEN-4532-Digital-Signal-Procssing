function [ output ] = linearRegression(X,Y)
%This function is a solution to basic linear regression:
% Least Square solution
    output = inv((X'*X))*X'*Y;
end

