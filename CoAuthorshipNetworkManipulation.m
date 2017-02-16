% Dernika Eirini -> BAPT1509
% Pitsios Stamatis -> BAPT1502
% Xanthopoulos Christos - George -> BAPT1504

% This script performs fundamental social network analysis tasks on the
% collaboration graph for the ICMB conference for the time period between
% 2002 and 2013.

% Clear workspace and command window.
clc;
clear all;
format short;

% Set the period of years.
Years = 2002:1:2013;
YearsNum = length(Years);

% Load weight matrices for each year.
for year = Years
    filename = strcat(['DataFiles/ICMB-' num2str(year) '.mat']);
    load(filename);
end;

% Load authors' names.
load('DataFiles/authors.mat');

% Set a container for the weight matrices of all years.
ICMB = cell(1, numel(Years));

% ICMB{1} = array_2002;
% ICMB{2} = array_2003;
% ICMB{3} = array_2004;
% ICMB{4} = array_2005;
% ICMB{5} = array_2006;
% ICMB{6} = array_2007;
% ICMB{7} = array_2008;
% ICMB{8} = array_2009;
% ICMB{9} = array_2010;
% ICMB{10} = array_2011;
% ICMB{11} = array_2012;
% ICMB{12} = array_2013;

for y = 1:YearsNum
    ICMB{y} = eval(genvarname(strcat(['array_' num2str(Years(y))])));
end;

% Get the number of nodes N.
N = size(ICMB{1},1);

% Construct the overall graph weight matrix.
W = zeros(N, N);
for y = 1:1:YearsNum
    W = W + ICMB{y};
end;

% Set up a vector of indices pointing to the diagonal elements of the
% weight matrix W.
Idiag = 1:N+1:N*N;

% Re-initialize the overall weight matrix W so that fundamental social
% network analysis tasks can be performed. W should be a binary adjacency
% matrix so that W[i,j] = 1 indicates the presence of an edge between
% authors i and j. Moreover, the diagonal elements of W should also be set
% to zero.
W0 = W;
W0(W0 > 1) = 1;
W0(Idiag) = 0;

% Extract connected components of co-authorship network.
% Initially extract the corresponding NeighboursList.
NL = NeighboursList(W0);
C = ConnectedComponents(NL);

% Get the number of connected components.
components_num = length(C);

% The number of top components which we want to estimate centrality measures
NumOfComponentsToInvestigate = 5;

% The total number of users to retrieve from each component
NumOfTopAuthorsToRetrieve = 10;

% Get the size of each connected component.
components_sizes = zeros(1, components_num);
for k = 1:1:components_num
    components_sizes(k) = length(C{k});
end;

% Sort connected components sizes in descending order.
[SortedComponentsSizes, SortedComponentsIndices] = sort(components_sizes, 'descend');

% Get the top N connected components sizes and corresponding indices.
TopNComponentsSizes = SortedComponentsSizes(1:NumOfComponentsToInvestigate);
TopNComponentsIndices = SortedComponentsIndices(1:NumOfComponentsToInvestigate);

% Loop for every connected component
for i = 1:1:NumOfComponentsToInvestigate
    % Fetch index of current component
    component_index = TopNComponentsIndices(i);

    % Fetch size of current component
    component_size = TopNComponentsSizes(i);

    % Fetch a vector with the nodes in the current component
    component = C{component_index};

    % Compute diagonal indexes for the current component
    Idiag = 1:component_size + 1:component_size * component_size;

    % Subset original adjacency matrix, so that we keep only the part that we are interested in, based on the
    % current component
    W1 = W(component, component);

    % Fetch the authors in the current component
    AuthorsInComponent = authors(component, :);

    % Make necessary modifications on W1, so that it is a valid format for Floyd-Warshall algorithm.
    W1(W1 > 1) = 1;
    W1(W1 == 0) = inf;
    W1(Idiag) = 0;

    % Call Floyd Warshall Algorithm
    [D, P] = FloydWarshall(W1);

    % Extract closeness centrality measure for each author in the component.
    CC = ComputeClosenessCentrality(D);

    % Extract betweenness centrality measure for each author in the component.
    BC = ComputeBetweennessCentrality(P);

    % Extract eccentricity centrality measure for each author in the component.
    EC = ComputeEccentricityCentrality(D);

    % Extract eigenvector centrality measure for each author in the component.
    W1(W1 == inf) = 0;
    EVC = ComputeEigenvectorCentrality(W1);

    % Fix the number of top authors to retrieve.
    if (component_size >= NumOfTopAuthorsToRetrieve)
        N = NumOfTopAuthorsToRetrieve;
    else
        N = component_size;
    end;

    ReportTopNAuthors(CC, 'Closeness Centrality', N, AuthorsInComponent, i, 'descend');
    ReportTopNAuthors(BC, 'Betweenness Centrality', N, AuthorsInComponent, i, 'descend');
    ReportTopNAuthors(EC, 'Eccentricity Centrality', N, AuthorsInComponent, i, 'ascend');
    ReportTopNAuthors(EVC, 'Eigenvector Centrality', N, AuthorsInComponent, i, 'descend');
end;
