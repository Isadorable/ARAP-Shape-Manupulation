%Matrix G contains information about the neighbors of every single edges.
%GIndeces is used to support an easy reading of G. Contains the index for
%every vertex in G
function [G, GIndeces] = computeG( V, E, F)

G = zeros(8,4,size(E,1));
GIndeces = zeros(size(E,1),4);

for  k = 1:size(E,1)
    %find the neighbors of E(k)
    viI = E(k,1);
    vjI = E(k,2);
    vi = V(viI,:);
    vj = V(vjI,:);
    [vlI, vrI] = findNeighbours(E(k,:), F, V);
    vl = V(vlI,:);
    if ~isnan(vrI)
        vr = V(vrI,:);
    end
    
    
    if isnan(vrI)
        G(1:end,1:end,k) = [vi(1), vi(2), 1, 0; vi(2), -vi(1), 0, 1;...
            vj(1), vj(2), 1, 0; vj(2), -vj(1), 0, 1;...
            vl(1), vl(2), 1, 0; vl(2), -vl(1), 0, 1;...
            NaN, NaN, NaN, NaN; NaN NaN, NaN, NaN];
        GIndeces(k,:) = [viI; vjI; vlI; NaN];
        
    else
        G(1:end,1:end,k) = [vi(1), vi(2), 1, 0; vi(2), -vi(1), 0, 1;...
            vj(1), vj(2), 1, 0; vj(2), -vj(1), 0, 1;...
            vl(1), vl(2), 1, 0; vl(2), -vl(1), 0, 1;...
            vr(1), vr(2), 1, 0; vr(2), -vr(1), 0, 1];
        GIndeces(k,:) = [viI; vjI; vlI; vrI];
        
    end
    
end
end

function  [vl, vr] = findNeighbours(e, F, V)
    [row, ~] = find(F == e(1));
    [rowI, ~] = find(F(row,:) == e(2));
    row = row(rowI,:);
    if (size(rowI,1) == 2)
        vl = F(row(1),find(F(row(1),:) ~= e(1) & F(row(1),:) ~= e(2)));
        vr = F(row(2),find(F(row(2),:) ~= e(1) & F(row(2),:) ~= e(2)));
        
    else
        vl = F(row(1),find(F(row(1),:) ~= e(1) & F(row(1),:) ~= e(2)));
        vr = NaN;
    end
end


