% Dernika Eirini -> BAPT1509
% Pitsios Stamatis -> BAPT1502
% Xanthopoulos Christos - George -> BAPT1504

function [ EC ] = ComputeEccentricityCentrality (D)
% This function computes the eccentricity of each node, based on the shortest distances matrix D
% Returns a vector EC, where EC(i) is the eccentricity of node i

% Get size of distance matrix
N = size(D, 1);

% Initialize empty vector
EC = zeros(1, N);

% For every node, find the longest shortest path toward all other nodes.
for i = 1:1:N
    EC(i) = max(D(i, :));
end;

end
