%this function analize the faces matrix F. It creates a new matrix E where
%every new line is a pair of connected vertices. Duplicate rows are deleted.
function [ edges ] = getEdges( faces )
%remove duplicates
edges = unique([faces(:,1:2);faces(:,2:3);[faces(:,1),faces(:,3)]],'rows');
i = 1;

%managing dynamic matrix
while(true)
    [row,~] = find(edges(:,2) == edges(i,1) & edges(:,1) == edges(i,2));
    for j = 1:size(row,1)
        edges(row(j),:) = [];
    end
    i = i+1;
    if i>size(edges,1)
        break;
    end
end
end

