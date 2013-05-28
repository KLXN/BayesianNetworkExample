%
% Example of Bayesian network with discrete, binary nodes.
% Author: Marek Kendziorek (marek@kendziorek.pl)
%
%

clear all;
close all;

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

% nodes CPDs
nodeACpd = [0.5 0.5];
nodeBCpd = [0.5 0.9 0.5 0.1];
nodeCCpd = [0.8 0.2 0.2 0.8];
nodeDCpd = [1 0.1 0.1 0.01 0 0.9 0.9 0.99];
% nodeECpd =
% nodeFCpd =
% nodeGCpd =
% nodeHCpd =

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

%% Defininf CPD (Conditional Probability Distribution)
bnet.CPD{nodeA} = tabular_CPD(bnet, nodeA, nodeACpd);
bnet.CPD{nodeB} = tabular_CPD(bnet, nodeB, nodeBCpd);
bnet.CPD{nodeC} = tabular_CPD(bnet, nodeC, nodeCCpd);
bnet.CPD{nodeD} = tabular_CPD(bnet, nodeD, nodeDCpd);

%% Choosing junction tree engine for inference
engine = jtree_inf_engine(bnet);

%% Defining observed evidence
evidence = cell(1,N);
evidence{nodeD} = 2; %false = 1; true = 2; We are looking

%% Connecting evidence and engine
[engine, loglik] = enter_evidence(engine, evidence);

%% Computing probability
marg = marginal_nodes(engine, nodeB);
marg.T
pFalse = marg.T(1); %probability that it's not true
pTrue = marg.T(2); % probability that it's true