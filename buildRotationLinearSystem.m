%This function creates the elements for the linear system at page 24 of the original paper.
%it will allow free deformation of the mesh
function [ VPrime ] = buildRotationLinearSystem(GIndeces, G, V, E, F, H, linkedTriangle)
W = 5000;
A = zeros(size(E,1)*2+size(H,1)*2,size(V,1)*2);
b = zeros(size(E,1)*2+size(H,1)*2,1);
partialResult = zeros(size(E,1)*2,8);
indicesGuide = 1:2:size(E,1);
g = 1;
weightI = 1;  
index = 1;

%compute h according to the type of edge (border or not)
for i = 1:size(E,1)
    eSquare = [ G(3,1,i)-G(1,1,i), G(3,2,i)-G(1,2,i); G(3,2,i)-G(1,2,i), -(G(3,1,i)-G(1,1,i))];
     
    if isnan(G(7,1,i))
        zerosones = [-1,0,1,0,0,0;....
                     0,-1,0,1,0,0];         
        tempG = (G(1:6,:,i)'*G(1:6,:,i))\G(1:6,:,i)';         
        partialResult(index:index+1,1:6) = zerosones-eSquare*tempG(1:2,:);
    else
        zerosones = [-1,0,1,0,0,0,0,0;....
                    0,-1,0,1,0,0,0,0];
        tempG = (G(:,:,i)'*G(:,:,i))\G(:,:,i)';        
        partialResult(index:index+1,:) = zerosones-eSquare*tempG(1:2,:);
    end
    index = index+2;
end

%fill matrix A
for i = 1:2:size(A,1)    
    if i<=size(E,1)*2
        for j = 1:4
            vCoord = GIndeces(g,j);
            if ~isnan(vCoord)
                ind = indicesGuide(vCoord);
                A(i:i+1,ind:ind+1)= partialResult(i:i+1,j*2-1:j*2);
            end
        end
    else        
        fprintf('Weight : %f - LinkedTriangleIndices: %f \n',weightI,linkedTriangle(weightI,1));        
        vCoord = indicesGuide(F(linkedTriangle(weightI,1),1));
        A(i,vCoord) = W*linkedTriangle(weightI,2);
        A(i+1,vCoord+1) = W*linkedTriangle(weightI,2);
        
        vCoord = indicesGuide(F(linkedTriangle(weightI,1),2));
        A(i,vCoord) = W*linkedTriangle(weightI,3);
        A(i+1,vCoord+1) = W*linkedTriangle(weightI,3);
        
        vCoord = indicesGuide(F(linkedTriangle(weightI,1),3));
        A(i,vCoord) = W*linkedTriangle(weightI,4);
        A(i+1,vCoord+1) = W*linkedTriangle(weightI,4);
        
        weightI = weightI + 1;
    end
    g = g+1;
end

%fill b
weightI = 1;
for i = size(E,1)*2+1:2:size(b,1)
    b(i,:) = W*H(weightI,1);
    b(i+1,:) = W*H(weightI,2);
    weightI = weightI+1;
end

VPrime = (A' * A) \ (A' * b);

VPrime = [VPrime(1:2:end),VPrime(2:2:end)];
end

