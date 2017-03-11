% Dernika Eirini -> BAPT1509
% Pitsios Stamatis -> BAPT1502
% Xanthopoulos Christos - George -> BAPT1504

function [SP] = Path(u, v, P)

% This function returns a cell array SP where each cell contains one or more lists of the sequence of graph nodes
% composing the shortest paths from node u to node v, given the predecessor matrix P.
%
% Source: http://stackoverflow.com/questions/11370041/floyd-warshall-all-shortest-paths

SP = {};
if (~isempty(P{u, v}) && u ~= v)
    for k = P{u, v}
        if (k == -1)
            SP{end + 1} = [u v];
        else
            paths_I_K = Path(u, k, P);
            paths_K_J = Path(k, v, P);
            for i_k = paths_I_K
                for k_j = paths_K_J
                    SP{end + 1} = [i_k{1}  k_j{1}(2)];
                end;
            end;
        end;
    end;
end;
