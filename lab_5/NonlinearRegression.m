function [ output ] = NonlinearRegression(X,Y,penalty)
%The penalty term we add consists of usual norm
   xsquare = X.^2;
   xcubic = X.^3;
   ONE = ones(600,301);
   X = horzcat(xsquare,xcubic,X,ONE);
   output = inv(X'*X + penalty*eye(size(X,2)))*X'*Y;

end

