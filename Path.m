function [SP] = Path(u, v, P)

% This function returns the vector SP which corresponds to the sequence of
% graph nodes composing the shortest path from node u to node v given the
% predecessor matrix P and the final shortest paths distance matrix D.
% Note that vector SP must be initially passed as an empty matrix.
%
% Source: http://stackoverflow.com/questions/11370041/floyd-warshall-all-shortest-paths

SP = {};
if (~isempty(P{u, v}) && u ~= v)
    for (k = P{u, v})
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
