function isIn = checkIfPointIsInObstacle(point,obstacleData)
    isIn = false;
    x = point(1);
    y = point(2);
    z = point(3);
    for i=1:size(obstacleData,1)
        xCenter = obstacleData(i,1);
        yCenter = obstacleData(i,2);
        zCenter = obstacleData(i,3);
        width = obstacleData(i,4);
        length = obstacleData(i,5);
        height = obstacleData(i,6);
        xDistance = abs(x-xCenter);
        yDistance = abs(y-yCenter);
        zDistance = abs(z-zCenter);
        if xDistance < width/2 & yDistance < length/2 & zDistance < height/2
            isIn = true;
            return
        end
    end
end
