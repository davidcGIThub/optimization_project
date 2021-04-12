classdef rapidlyExploringRandomTreeStar < handle
    properties
        nodes
        nodeCount
        obstaclesData
        obstacles
        matlabGraph
        limits
        nodeGraphMaxSize
    end
    
    methods
        function obj = rapidlyExploringRandomTreeStar( startNode,obstacles,obstaclesData,limits)
            %assume start and end node not in obstacle
            obj.nodeGraphMaxSize = 1000;
            obj.nodes = zeros(obj.nodeGraphMaxSize,3);
            obj.nodes(1,:) = startNode;
            obj.matlabGraph = graph();
            obj.matlabGraph = addnode(obj.matlabGraph,1);
            obj.nodeCount = 1;
            obj.obstacles = obstacles;
            obj.obstaclesData = obstaclesData;
            obj.limits = limits;
        end
        
        function [minimizedDistance , minimizedPath] = runOptimization(obj,endPoint, maxTime, maxIterations)
            tic;
            timeElapsed = 0;
            iterations = 0;
            while(timeElapsed < maxTime & iterations < maxIterations)
                obj.addNode();
                timeElapsed = toc
                iterations = obj.nodeCount
            end
            endNodeIndex = obj.findNodeClosestToEnd(endPoint);
            [smallestPath , minimizedDistance] = shortestpath(obj.matlabGraph,1,endNodeIndex);
            minimizedPath = obj.nodes(smallestPath,:);
            obj.clearTree();
        end
        
        function addNode(obj)
            connectionNotFound = true;
            node = createNodeInBounds(obj);
            while(connectionNotFound)
                [closestNode , closestIndex, distance,nodeIndicesWithinRadius,nodePathLengthsWithinRadius,pathLengthNewNode] = obj.findNodeWithShortestPathOfFiveClosest(node);
                if any(closestNode == inf)
                    node = createNodeInBounds(obj);
                else
                    connectionNotFound = false;
                end
            end
            %add node and edge
            obj.nodeCount = obj.nodeCount + 1;
            if obj.nodeCount >= obj.nodeGraphMaxSize
                obj.enlargeNodeGraph();
            end
            obj.matlabGraph = addnode(obj.matlabGraph,obj.nodeCount);
            obj.matlabGraph = addedge(obj.matlabGraph,obj.nodeCount,closestIndex,distance);
            obj.nodes(obj.nodeCount,:) = node;
            obj.rewireTree(nodeIndicesWithinRadius,nodePathLengthsWithinRadius, node, pathLengthNewNode);
        end
        
        function rewireTree(obj, nodeIndicesWithinRadius, nodePathLengthsWithinRadius, newNode, pathLengthNewNode)
            nodesWithinRadius = obj.nodes(nodeIndicesWithinRadius,:);
            distanceFromNewNodeToNodes = vecnorm(nodesWithinRadius - newNode,2,2);
            newPathLengths = distanceFromNewNodeToNodes + pathLengthNewNode;
            for i = 1:length(nodeIndicesWithinRadius)
                if newPathLengths(i) < nodePathLengthsWithinRadius(i)
                    obj.matlabGraph = addedge(obj.matlabGraph,nodeIndicesWithinRadius(i),obj.nodeCount,distanceFromNewNodeToNodes(i));
                end
            end
        end
        
        function xyzNode = createNodeInBounds(obj)
            nodeInObstacle = true;
            minLimit = obj.limits(1);
            maxLimit = obj.limits(2);
            width = abs(maxLimit - minLimit);
            center = (maxLimit + minLimit)/2;
            xyzNode = center + (rand(1,3)-.5)*width;
            obstacleCenters = obj.obstaclesData(:,1:3);
            dimensionsObstacles = obj.obstaclesData(:,4:6);
            while nodeInObstacle
                xyzDistancesToCenter = abs(xyzNode - obstacleCenters);
                if ~any(all(xyzDistancesToCenter<dimensionsObstacles,2))
                    nodeInObstacle = false;
                else
                    xyzNode = center + (rand(1,3)-.5)*width;
                end
            end
        end
        
        function [shortest , shortestIndex, distance,nodeIndicesWithinRadius,nodePathLengthsWithinRadius,pathLengthNewNode] = findNodeWithShortestPathOfFiveClosest(obj, node)
              shortest = [inf,inf,inf];
              shortestIndex = inf;
              distance = inf;
              pathLengthNewNode = inf;
              nodeIndicesWithinRadius = [];
              nodePathLengthsWithinRadius = [];
              fiveClosestIndexes = obj.findClosestFiveNodesIndexes(node);
              if isinf(fiveClosestIndexes(1))   
                  return
              else
                  pathLength = inf
                  fiveClosestIndexes = fiveClosestIndexes(~isinf(fiveClosestIndexes));
                  nodePathLengthsWithinRadius = zeros(length(fiveClosestIndexes),1);
                  for i =1:length(fiveClosestIndexes)
                      [path , newPathLength] = shortestpath(obj.matlabGraph,1,fiveClosestIndexes(i));
                      nodePathLengthsWithinRadius(i)  = newPathLength;
                      if newPathLength < pathLength
                          shortestIndex = fiveClosestIndexes(i);
                          pathLength = newPathLength;
                      end
                  end
                  shortest = obj.nodes(shortestIndex,:);
                  shortestNode = obj.nodes(shortestIndex,:);
                  distance = norm(shortestNode - node);
                  nodeIndicesWithinRadius = fiveClosestIndexes(fiveClosestIndexes ~= shortestIndex);
                  nodePathLengthsWithinRadius = nodePathLengthsWithinRadius(nodePathLengthsWithinRadius ~= pathLength);
                  pathLengthNewNode = pathLength + distance;
              end
        end
        
        function indexes = findClosestFiveNodesIndexes(obj, node)
            indexes = [inf, inf, inf, inf, inf];
            indexCount = 1;
            xyzDistancesToNodes = abs(node - obj.nodes(1:obj.nodeCount,:));
            distanceToNodes = vecnorm(xyzDistancesToNodes,2,2);
            minValue = 0;
            while isinf(indexes(5)) & ~isinf(minValue)
                [minValue , minIndex] = min(distanceToNodes);
                nextNode = obj.nodes(minIndex,:);
                lineSegment = [nextNode;node];
                if checkIfSegmentIntersectsObstacleList(lineSegment,obj.obstacles);
                    distanceToNodes(minIndex) = inf;
                else
                    indexes(indexCount) = minIndex;
                    indexCount = indexCount + 1;
                    distanceToNodes(minIndex) = inf;
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
            startNode = obj.nodes(1,:);
            obj.nodes = zeros(obj.nodeGraphMaxSize,3);
            obj.nodes(1,:) = startNode;
            obj.matlabGraph = graph();
            obj.matlabGraph = addnode(obj.matlabGraph,1);
            obj.nodeCount = 1;
        end
        
                
    end
end

