clear;
clc;
clf;

%initialize variables
maxTime = 100;
maxIterations = 2000;
numberOfObstacles = 3;
limits = [-10,10];
startPoint = [limits(1),limits(1),limits(1)];
endPoint = [limits(2),limits(2),limits(2)];
[obstacles, obstaclesData] = generateObstacleMap()

plotObstacles(obstacles);
hold on;
destinations = generateDestinations();
scatter3(destinations(:,1), destinations(:,2) , destinations(:,3),'filled' , 'r');

% rrt = rapidlyExploringRandomTreeStar(startPoint,obstacles,obstaclesData,limits);
% [distance, path ] = rrt.runOptimization(endPoint, maxTime, maxIterations);
% plot3(path(:,1), path(:,2),path(:,3));
% scatter3([path(1,1),path(end,1)] , [path(1,2),path(end,2)], [path(1,3),path(end,3)],'r');


% G = graph()
% G = addnode(G,'{[1,2,3]}')
% G = addnode(G,'{[4,6,2]}')
% G = addnode(G,'{[5,4.5,2]}')
% G = addnode(G,'[5,6,{2]}')
% G = addnode(G,'{[5,6,6]}')
% G = addedge(G,'{[5,6,6]}','{[4,6,2]}',4)
% G = addedge(G,'{[1,2,3]}','{[4,6,2]}',1)
% G = addedge(G,'{[1,2,3]}','[5,6,{2]}',23)
% G = addedge(G,'{[5,4.5,2]}','{[4,6,2]}',3)
% i = findnode(G,'{[4,6,2]}')
% n = numnodes(G)
% nodeIDs = nearest(G,'{[4,6,2]}',5)
% 
% 
% plot(G,'EdgeLabel',G.Edges.Weight)
% G = graph()
% plot(G)

% vecnorm(a,2,2) - might not need
% point - centers of obstacles
% all(all(a<0,2)) % use for finding closest
% this will tell if any point intersects