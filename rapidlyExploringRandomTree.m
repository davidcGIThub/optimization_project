classdef rapidlyExploringRandomTree < handle
    properties
        nodes
        nodeCount
        obstaclesData
        obstacles
        matlabGraph
        limits
        nodeGraphMaxSize
        paths
    end
    
    methods
        function obj = rapidlyExploringRandomTree(obstacles,obstaclesData,limits)
            %assume start and end node not in obstacle
            obj.nodeGraphMaxSize = 1000;
            obj.nodes = zeros(obj.nodeGraphMaxSize,3);
            obj.matlabGraph = graph();
            obj.matlabGraph = addnode(obj.matlabGraph,1);
            obj.nodeCount = 1;
            obj.obstacles = obstacles;
            obj.obstaclesData = obstaclesData;
            obj.limits = limits;
        end
        
        function [optimizedPaths, pathDistances,rrtTime,pathOptTime] = runOptimization(obj,maxTime,destinations)
            tic;
            obj.clearTree();
            timeElapsed = 0;
            obj.createGroundLevelConnections();
            while(timeElapsed < maxTime)
                obj.addNode();
                timeElapsed = toc
                iterations = obj.nodeCount
            end
%             endNodeIndex = obj.findNodeClosestToEnd(endPoint);
%             [smallestPath , minimizedDistance] = shortestpath(obj.matlabGraph,1,endNodeIndex);
%             minimizedPath = obj.nodes(smallestPath,:);
            numberOfDestinations = size(destinations,1);
            numberOfPaths = (numberOfDestinations^2 + numberOfDestinations)/2 - numberOfDestinations;
            obj.paths = cell(numberOfPaths,1);
            pathDistances = cell(numberOfPaths,1);
            pathCount = 1;
            for i=1:numberOfDestinations-1
                for j=i+1:numberOfDestinations
                    startNodeIndex = obj.findNodeClosestToEnd(destinations(i,:));
                    endNodeIndex = obj.findNodeClosestToEnd(destinations(j,:));
                    [smallestPath , minimizedDistance] = shortestpath(obj.matlabGraph,startNodeIndex,endNodeIndex);
                    obj.paths(pathCount) = {obj.nodes(smallestPath,:)};
                    pathDistances(pathCount) = {minimizedDistance};
                    pathCount = pathCount + 1;
                end
            end
            rrtTime = toc;
            [optimizedPaths, pathDistances] = obj.optimizePaths();
            pathOptTime = toc;
        end
        
        function addNode(obj)
            connectionNotFound = true;
            node = createNodeInBounds(obj);
            while(connectionNotFound)
                [closestNode , closestIndex, distance] = obj.findClosestNode(node);
                if any(closestNode == inf)
                    node = createNodeInBounds(obj);
                else
                    connectionNotFound = false;
                    [secondClosestNode , secondClosestIndex, secondDistance] = obj.findSecondClosestNode(node,closestIndex);
                end
            end
            %add node and edge
            obj.nodeCount = obj.nodeCount + 1;
            obj.nodes(obj.nodeCount,:) = node;
            if obj.nodeCount >= obj.nodeGraphMaxSize
                obj.enlargeNodeGraph();
            end
            obj.matlabGraph = addnode(obj.matlabGraph,obj.nodeCount);
            obj.matlabGraph = addedge(obj.matlabGraph,obj.nodeCount,closestIndex,distance);
            if ~any(secondClosestNode == inf)
                obj.matlabGraph = addedge(obj.matlabGraph,obj.nodeCount,secondClosestIndex,secondDistance);
            end
        end
        
        function xyzNode = createNodeInBounds(obj)
            nodeInObstacle = true;
            minLimit = obj.limits(1);
            maxLimit = obj.limits(2);
            width = abs(maxLimit - minLimit);
            center = (maxLimit + minLimit)/2;
            xyzNode = center + (rand(1,3)-.5)*width;
            xyzNode(3) = xyzNode(3)/2 + .1;
            obstacleCenters = obj.obstaclesData(:,1:3);
            dimensionsObstacles = obj.obstaclesData(:,4:6);
            while nodeInObstacle
                xyzDistancesToCenter = abs(xyzNode - obstacleCenters);
                if ~any(all(xyzDistancesToCenter<dimensionsObstacles,2))
                    nodeInObstacle = false;
                else
                    xyzNode = center + (rand(1,3)-.5)*width;
                    xyzNode(3) = xyzNode(3)/2 + .1;
                end
            end
        end
        
        function [closest , closestIndex, distance] = findClosestNode(obj, node)
            closest = [inf,inf,inf];
            closestIndex = 0;
            distance = inf;
            xyzDistancesToNodes = abs(node - obj.nodes(1:obj.nodeCount,:));
            distanceToNodes = vecnorm(xyzDistancesToNodes,2,2);
            %check size of above matrix
            for i = 1:obj.nodeCount
                [minValue , minIndex] = min(distanceToNodes);
                nextNode = obj.nodes(minIndex,:);
                lineSegment = [nextNode;node];
                if checkIfSegmentIntersectsObstacleList(lineSegment,obj.obstacles);
                    distanceToNodes(i) = inf;
                else
                    closest = nextNode;
                    closestIndex = minIndex;
                    distance = minValue;
                    return
                end
            end
        end
        
        function [secondClosest , secondClosestIndex, distance] = findSecondClosestNode(obj, node, closestIndex)
            secondClosest = [inf,inf,inf];
            secondClosestIndex = 0;
            distance = inf;
            xyzDistancesToNodes = abs(node - obj.nodes(1:obj.nodeCount,:));
            distanceToNodes = vecnorm(xyzDistancesToNodes,2,2);
            distanceToNodes(closestIndex) = inf;
            %check size of above matrix
            for i = 1:obj.nodeCount
                [minValue , minIndex] = min(distanceToNodes);
                nextNode = obj.nodes(minIndex,:);
                lineSegment = [nextNode;node];
                if checkIfSegmentIntersectsObstacleList(lineSegment,obj.obstacles);
                    distanceToNodes(i) = inf;
                else
                    secondClosest = nextNode;
                    secondClosestIndex = minIndex;
                    distance = minValue;
                    return
                end
            end
        end
        
        function enlargeNodeGraph(obj)
            obj.nodes = [obj.nodes ; zeros(obj.nodeGraphMaxSize,3)];
            obj.nodeGraphMaxSize = obj.nodeGraphMaxSize*2;
        end
        
        function nodeIndex = findNodeClosestToEnd(obj, endPoint)
            xyzDistancesToNodes = abs(endPoint - obj.nodes(1:obj.nodeCount,:));
            distanceToNodes = vecnorm(xyzDistancesToNodes,2,2);
            [minValue, nodeIndex] = min(distanceToNodes);
        end
        
        function clearTree(obj)
            obj.nodeGraphMaxSize = 1000;
            obj.nodes = zeros(obj.nodeGraphMaxSize,3);
            obj.matlabGraph = graph();
            obj.matlabGraph = addnode(obj.matlabGraph,1);
            obj.nodeCount = 1;
            obj.paths = {};
        end
        
        function [optimizedPaths , pathDistances] = optimizePaths(obj)
            numberOfPaths = size(obj.paths,1);
            optimizedPaths = cell(numberOfPaths,1);
            pathDistances = cell(numberOfPaths,1);
            for i=1:numberOfPaths
                path_being_optimized = i
                path = obj.paths{i};
                j = 1;
                distance = 0;
                while(j <= size(path,1)-2)
                    node1 = path(j,:);
                    node2 = path(j+2,:);
                    lineSegment = [node1;node2];
                    if ~checkIfSegmentIntersectsObstacleList(lineSegment,obj.obstacles)
                        path(j+1,:) = [];
                    else
                        j = j+1;
                        previousNode = path(j-1,:);
                        currentNode = path(j,:);
                        distance = distance + norm(previousNode - currentNode);
                    end
                end
                if j < size(path,1)
                    nextNode = path(j+1,:);
                    currentNode = path(j,:);
                    distance = distance + norm(nextNode - currentNode);
                end
                pathDistances(i) = {distance};
                optimizedPaths(i) = {path};
            end
        end
        
        function createGroundLevelConnections(obj)
            width = round(abs(obj.limits(2) - obj.limits(1)))
            for i = 0:width-1
                for j = 0:width-1
                    %add valid node
                    node = [i+.5,j+.5,0.1];
                    if ~obj.checkIfGroundLevelNodeIsInBuilding(node)
                        node
                        obj.nodeCount = obj.nodeCount + 1;
                        iterations = obj.nodeCount
                        time_elapsed = toc
                        obj.nodes(obj.nodeCount,:) = node;
                        if obj.nodeCount >= obj.nodeGraphMaxSize
                            obj.enlargeNodeGraph();
                        end
                        obj.matlabGraph = addnode(obj.matlabGraph,obj.nodeCount);
                        %add connections
                        xyzDistancesToNodes = abs(node - obj.nodes(1:obj.nodeCount-1,:));
                        distanceToNodes = vecnorm(xyzDistancesToNodes,2,2);
                        for k=1:obj.nodeCount-1
                            if distanceToNodes(k) <= 1
                                k
                                d = distanceToNodes(k)
                                obj.matlabGraph = addedge(obj.matlabGraph,obj.nodeCount,k,distanceToNodes(k));
                            end
                        end
                    end
                end
            end
        end
        
        function isInBuilding = checkIfGroundLevelNodeIsInBuilding(obj,node)
            isInBuilding = false;
            obstacleCenters = obj.obstaclesData(:,1:2);
            dimensionsObstacles = obj.obstaclesData(:,4:5)/2;
            xyDistancesToCenter = abs(node(1,1:2) - obstacleCenters);
            if any(all(xyDistancesToCenter<dimensionsObstacles,2))
                    isInBuilding = true
            end
        end

    end
            
end

