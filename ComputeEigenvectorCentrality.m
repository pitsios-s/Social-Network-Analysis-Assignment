% Dernika Eirini -> BAPT1509
% Pitsios Stamatis -> BAPT1502
% Xanthopoulos Christos - George -> BAPT1504

function [ EVC ] = ComputeEigenvectorCentrality (W)
% This function computes the eigenvector centrality of each node, based on the adjacency matrix W.
% For the computation, the POWER ITERATION method is utilized.
% Returns a vector EVC, where EVC(i) is the eigenvector centrality of node i

% Maximum Number of iterations to perform
max_iters = 10000;

N = size(W, 1);
v = ones(1, N);
for i = 1:max_iters
    x = v * W;
    v = x / norm(x);
end;

EVC = v;

end
