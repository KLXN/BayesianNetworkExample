%
% Example of Bayesian network with discrete, binary nodes.
% Author: Marek Kendziorek (marek@kendziorek.pl)
%
%

%% Parameters
N = 4; %number of nodes

% nodes' IDs
nodeA = 1; 
nodeB = 2; 
nodeC = 3; 
nodeD = 4;
nodeE = 5;
nodeF = 6;
nodeG = 7;
nodeH = 8;


%% Creating dag (direct acyclic graph)
dag = zeros(N,N); %matrix of connections
dag(nodeA,[nodeC nodeB]) = 1;
dag(nodeC,nodeD) = 1;
dag(nodeB,nodeD)=1;

%% Defining nodes types and sizes (in this case all nodes are binary)
discrete_nodes = 1:N;
node_sizes = 2*ones(1,N); 

%% Creating Bayes net
onodes = []; %observed nodes - for now default value
bnet = mk_bnet(dag, node_sizes, 'discrete', discrete_nodes, 'observed', onodes);