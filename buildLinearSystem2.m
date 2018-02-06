%This function creates the elements for the linear system at page 26 of the original paper.
%it will adjust the scale of the final vertices
function [A, b] = buildLinearSystem2(coordID, E, H, V, linkedTriangle, T)
A = zeros(size(E,1)+size(linkedTriangle,1),size(V,1));
b = zeros(size(A,1),1);
W = 1000;
weightI = 1;

%A and b composition - Second part : scale adjustment
for i = 1:size(A,1)
    if i<=size(E,1)
        A(i,E(i,1)) = -1;
        A(i,E(i,2)) = 1;
    else
        A(i,E(linkedTriangle(weightI,1),linkedTriangle(weightI,2))) = W;
        weightI = weightI + 1;
    end
end

for i = 1:size(E,1)
    bTemp = T(:,:,i)*(V(E(i,2),1:2)-V(E(i,1),1:2))';
    b(i,:) = bTemp(coordID,1);
end
coo = 1;
for i = size(E,1)+1:size(E,1)+size(H,1)
    b(i,:) = W*H(coo,coordID);
    coo = coo+1;
end

end