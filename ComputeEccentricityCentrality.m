function [ EC ] = ComputeEccentricityCentrality (D)
% This function computes the eccentricity of each node, based on the shortest distances matrix D
% Returns a vector EC, where EC(i) is the eccentricity of node i

% Initialize empty vector
EC = [];

% Get size of distance matrix
N = size(D, 1);

% For every node, find the longest shortest path toward all other nodes.
for i = 1:1:N
    EC = [EC, max(D(i, :))];
end;

end
