function[ D ] = euclid(G,G2 )
    
    %Calculates euclidean distance between two points.
    V = G - G2;
    D = sqrt(V * V');
    
end

