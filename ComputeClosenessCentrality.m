function [ CC ] = ComputeClosenessCentrality( D, Idiag )
% This function computes the closeness centrality for all nodes of the
% graph. Input D is a matrix that stores the shortest distances from a node
% to all others. Since our graph is disconnected, we compute closeness
% centrality based on the theory for disconnected graphs which can be found
% here
% https://en.wikipedia.org/wiki/Closeness_centrality#In_disconnected_graphs/
% and here
% https://toreopsahl.com/2010/03/20/closeness-centrality-in-networks-with-disconnected-components/

    N = size(D, 2);
    D(Idiag) = inf;
    D0 = 1 ./ D;
    CC = sum(D0, 2) ./ N;
    
end
