function [NL] = NeighboursList(W)

% This function extracts the neighbours' list for corresponding to the 
% weight matrix W which is assummed to binary matrix indicating the 
% presence or absence of an edge between a given pair of nodes. Diagonal
% elements of matrix W are also assummed to be zero.

% NL is a cell array of vectors such that the element NL{u} stores the
% indices of nodes that are reachable from node u.

nodes_num = size(W,1);
NL = cell(1,nodes_num);
for v = 1:1:nodes_num
    NL{v} = find(W(v,:)==1);
end;

end

