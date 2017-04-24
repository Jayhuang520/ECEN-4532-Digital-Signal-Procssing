function [output] = Regularization(X,Y,penalty)
%In regression and we also add a peanalty on the form of w, we solved:
    output = inv(X'*X + penalty*eye(size(X,2)))*X'*Y;

end

