function doesIntersect = checkIfSegmentIntersectsObstacleList(lineSegment,obstacleList)
    doesIntersect = false;
    for i=1:size(obstacleList,4)
        obstacle = obstacleList(:,:,:,i);
        if checkIfSegmentIntersectsObstacle(lineSegment,obstacle)
            doesIntersect = true;
            return
        end
    end
end
