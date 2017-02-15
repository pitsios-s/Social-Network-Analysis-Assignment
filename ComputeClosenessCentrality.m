function [ CC ] = ComputeClosenessCentrality( D )
% This function computes the closeness centrality for all nodes of the
% graph. Input D is a matrix that stores the shortest distances from a node
% to all others.

N = size(D, 2);
CC = zeros(1, N);
for i = 1:1:N
    CC(i) = (N - 1) / sum(D(i, :));
end;
    
end
