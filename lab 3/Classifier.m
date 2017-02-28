function [ output ] = Classifier(distance,rows)
%Find the 5 nearest neighbor
n = 5;
index = zeros(25,n);
temp = zeros(1,25);
row = rows*25-24;
output = zeros(1,6);
% col = columns*25-24;
for i = row:row+24
    %looping through the 25 songs
    index(i,:) = FindNMinimum(distance(i,:),5);
end
    index = floor(index/25)+1;

    for i = 1:25
        temp(1,i) = mode(index(i,:));
    end
    
    for i = 1:25
        switch(temp(1,i))
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

