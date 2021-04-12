function doesIntersect = checkIfSegmentIntersectsObstacle(lineSegment,obstacle)
    doesIntersect = false;
    for i=1:size(obstacle,3)
        triangle = obstacle(:,:,i);
        if checkIfLineSegmentIntersectsTriangle(lineSegment,triangle)
            doesIntersect = true;
            return
        end
    end
end

