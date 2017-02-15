function [ EVC ] = ComputeEigenvectorCentrality (W)
% This function computes the eigenvector centrality of each node, based on the adjacency matrix W
% Returns a vector EVC, where EVC(i) is the eigenvector centrality of node i

 epsilon = 1e-10000;
 max_iters = 10000;
 N = size(W, 1);
 X0 = repmat(0, 1, N);
 X1 = repmat(1/N, 1, N);
 iter = 0;
 while (sum(abs(X0 - X1)) > epsilon && iter < max_iters)
     X0 = X1;
     X1 = X1 * W;
     M = max(X1);
     X1 = X1 / M;
     iter = iter + 1;
 end;

EVC = X1;
iter
end
