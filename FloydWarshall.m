function [D,P] = FloydWarshall(W)

% This function computes shortest paths' distances for each pair of nodes
% within the graph whose initial weight (adjacency) matrix is stored in
% matrix W. Matrix W is assummed to be properly initialized.
% Element D[i,j] of matrix D stores the shortest path distance from node i 
% to node j.
% Matrix P is the corresponding predecessor matrix so that element P[i,j]
% stores the last vertex traversed within the shortest path connecting
% nodes i and j.

% Get the number of nodes pertaining to the graph.
nodes_num = size(W,1);

% Initialize internal matrix D.
D = W;

% Initialize internal matrix P.
P = zeros(nodes_num,nodes_num);

% Main Algorithm.
for k = 1:1:nodes_num
    for i = 1:1:nodes_num
        for j = 1:1:nodes_num
            if(D(i,j) > D(i,k) + D(k,j))
                D(i,j) = D(i,k) + D(k,j);
                P(i,j) = k;
            end;
        end;
    end;
end;

end
