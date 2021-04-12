clear;
clc;
clf;

%initialize variables
% maxTime = 100;
% maxIterations = 2000;
limits = [0,10];
destinations = generateDestinations();
startPoint = destinations(1,:) + .1;
endPoint = destinations(3,:);
[obstacles, obstaclesData] = generateObstacleMap();
maxTime = 3600;

plotObstacles(obstacles);
hold on;
destinations = generateDestinations();
scatter3(destinations(:,1), destinations(:,2) , destinations(:,3),'filled' , 'r');

rrt = rapidlyExploringRandomTree(startPoint,obstacles,obstaclesData,limits);
[paths, pathDistances] = rrt.runOptimization(maxTime,destinations);
for i = 1:size(paths,1)
    path = paths{i};
    plot3(path(:,1), path(:,2),path(:,3));
end
hold off;