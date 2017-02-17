function [output] = SimilarityMatrix(mfcc,i,j)

    output = mfcc(:,i)'*mfcc(:,j)/(norm(mfcc(:,i))*norm(mfcc(:,j)));

end

