function [ EVC ] = ComputeEigenvectorCentrality (W)
% This function computes the eigenvector centrality of each node, based on the adjacency matrix W.
% For the computation, the POWER ITERATION method is utilized.
% Returns a vector EVC, where EVC(i) is the eigenvector centrality of node i

% Maximum Number of iterations to perform
max_iters = 10000;

N = size(W, 1);
v = repmat(1, 1, N);
for i = 1:max_iters
    x = v * W;
    v = x / norm(x);
end;

EVC = v;

end
