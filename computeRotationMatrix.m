function [ T ] = computeRotationMatrix(VPrime, G, GIndices)
%rotation matrix cretion
%we want to find ck and sk
T = zeros(2,2,size(G,3));

for k = 1:size(G,3)
    if isnan(G(7,1,k))
        b = [ VPrime(GIndices(k,1),1);VPrime(GIndices(k,1),2);...
            VPrime(GIndices(k,2),1);VPrime(GIndices(k,2),2);...
            VPrime(GIndices(k,3),1);VPrime(GIndices(k,3),2)];
        r = (G(1:6,:,k)'*G(1:6,:,k))\G(1:6,:,k)'*b;
    else
        b = [ VPrime(GIndices(k,1),1);VPrime(GIndices(k,1),2);...
            VPrime(GIndices(k,2),1);VPrime(GIndices(k,2),2);...
            VPrime(GIndices(k,3),1);VPrime(GIndices(k,3),2);...
            VPrime(GIndices(k,4),1);VPrime(GIndices(k,4),2)];
        r = (G(:,:,k)'*G(:,:,k))\G(:,:,k)'*b;
    end

%r(1) is ck - r(2) is sk
T(1:end,1:end,k) = (1/sqrt(r(1)^2+r(2)^2))*[r(1),r(2);-r(2),r(1)];
end

end

