% Dernika Eirini -> BAPT1509
% Pitsios Stamatis -> BAPT1502
% Xanthopoulos Christos - George -> BAPT1504

function [C] = ConnectedComponents(NL)

% This function extracts the connnected components of a given undirected
% graph whose neighbours' list NL is given as input. C is a cell array of
% vectors so that each vector stores the indices of each connected component.

% Initialize the cell array C storing the connected components of the graph.
C = cell(1,0);
% Get the number of graph nodes.
nodes_num = length(NL);
% Mark all nodes as unvisited.
visited = false * ones(1,nodes_num);
% Initialize the number of connected components found so far.
components_num = 0;
for v = 1:1:nodes_num
    % If v is not visited yet, it's the start of a newly discovered
    % component containing v.
    if(~visited(v)) % Process the component containing v.
        components_num = components_num + 1;
        component = []; % Initialize component container.
        Q = []; % Initialize queue for implementing breadth-first search.
        Q = enqueue(Q,v); % Start the traversal from node v.
        visited(v) = true;
        while(~isempty(Q))
            [Q,w] = dequeue(Q); % w is a node in this component.
            component = [component, w];
            % Get all nodes neighbouring w.
            node_neighbours = NL{w};
            % Traverse each unvisited node neighbouring w.
            for node_index = 1:1:length(node_neighbours)
                node = node_neighbours(node_index);
                if(~visited(node))
                    % Another node within the current component has been
                    % found.
                    visited(node) = true;
                    Q = enqueue(Q,node);
                end;
            end;
        end;
        C{components_num} = component;
    end;
end;


    function [Q] = enqueue(Q,element)

    % This is a subfunction implementing the enqueue operation within a
    % queue which is realzed as a vector of elements

    Q = [Q,element];

    end

    function [Q,element] = dequeue(Q)

    % This is a subfunction implementing the dequeue operation within a
    % queue queue which is realized as a vector of elements.

    element = Q(1);
    Q = Q(2:end);

    end

end
