clear;
clc;
clf;

%initialize variables
% maxTime = 100;
% maxIterations = 2000;
limits = [0,10];
destinations = generateDestinations();
[obstacles, obstaclesData] = generateObstacleMap();
maxTime = 3600*3;

plotObstacles(obstacles);
hold on;
scatter3(destinations(:,1), destinations(:,2) , destinations(:,3),'filled' , 'r');
hold on;

rrt = rapidlyExploringRandomTree(obstacles,obstaclesData,limits);
[paths, pathDistances,rrtTime,pathOptTime] = rrt.runOptimization(maxTime,destinations);
for i = 1:size(paths,1)
    path = paths{i};
    plot3(path(:,1), path(:,2),path(:,3));
end
hold off;        
