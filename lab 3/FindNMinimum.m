function [ index] = FindNMinimum( input,n )
    SortMatrix = sort(input);
    MinValue = SortMatrix(1:n);
    index = zeros(1,n);
    for i = 1:n
        index(1,i) = find(input == MinValue(1,i));
    end
end

