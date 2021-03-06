% Dernika Eirini -> BAPT1509
% Pitsios Stamatis -> BAPT1502
% Xanthopoulos Christos - George -> BAPT1504

function [ BC ] = ComputeBetweennessCentrality( P )
% This function computes the normalized betweenness centrality of all nodes in the graph, given the predecessor matrix P
% BC(i) contains the betweenness centrality of node i.

N = size(P, 1);

BC = [];
for i = 1:1:N
    BC = [BC, 0];
end;

for i = 1:1:N-1
    for j = i + 1:1:N
        path = Path(i, j, P);
        NumOfPaths = length(path);

        for k = 1:1:NumOfPaths
            CurrentPath = path{k};
            NumOfElements = length(CurrentPath);
            for element = 2:1:NumOfElements - 1
                item = CurrentPath(element);
                BC(item) = BC(item) + 1 / NumOfPaths;
            end;
        end;
    end;
end;

% Normalization
BC = BC / ( ((N-1) * (N-2)) / 2);

end
