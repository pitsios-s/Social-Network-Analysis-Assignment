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
ICMB = cell(1,numel(Years));

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
W = zeros(N,N);
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
W0(W0>1) = 1;
W0(Idiag) = 0;

% Extract Degree Centrality measure for each author.
Degrees = sum(W0,2);

% Extract Closeness Centrality measure for each author.
W1 = W;
W1(W1 > 1) = 1;
W1(W1 == 0) = inf;
W1(Idiag) = 0;
[D, P] = FloydWarshall(W1);
CC = ComputeClosenessCentrality(D, Idiag);

% Extract Betweenness Centrality measure for each author.

% Report top 10 authors according to Degree Centraluity.
ReportTopNAuthors(Degrees, 'Degree Centrality', 10, authors);

% Report top 10 authors according to Closeness Centraluity.
ReportTopNAuthors(CC, 'Closeness Centrality', 10, authors);
