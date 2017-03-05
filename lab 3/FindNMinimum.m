function [ index] = FindNMinimum( input,n )
    SortMatrix = sort(input);
    len = size(input,2);
%     MinValue = SortMatrix(len-4:len);
    MinValue = SortMatrix(len-4:len);
    index = zeros(1,n);
    for i = 1:n
        index(1,i) = find(input == MinValue(1,i));
    end
end

