function [ output ] = ClassifierCross(distance,distIndex)
%Find the 5 nearest neighbor
n = 5;
index = zeros(25,n);
temp = zeros(1,25);
% row = rows*25-24;
output = zeros(1,6);
% col = columns*25-24;
loopi = 1;
% for i = row:row+24
%     %looping through the 25 songs
%     index(loopi,:) = FindNMinimum(distance(i,:),5);
%     loopi = loopi + 1;
% end

for i = 1:5
    %loop through the 5 different songs
    index(loopi,:) = FindNMinimum(distance(distIndex(1,i),:),5);
     loopi = loopi + 1;
end

    index = floor(index/25)+1;

    for j = 1:5
        temp(1,j) = mode(index(j,:));
    end
    
    for k = 1:5
        switch(temp(1,k))
            case 1
                output(1,1) = output(1,1) + 1;
            case 2
                output(1,2) = output(1,2) + 1;
            case 3
                output(1,3) = output(1,3) + 1;
            case 4
                output(1,4) = output(1,4) + 1;
            case 5
                output(1,5) = output(1,5) + 1;
            case 6
                output(1,6) = output(1,6) + 1;
        end
    end
end

