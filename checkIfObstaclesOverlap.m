function doesOverlap = checkIfObstaclesOverlap(obstacleData,obstacleDataList)
    numberOfObstaclesToCheck = size(obstacleDataList,1);
    doesOverlap = false;
    xCenter = obstacleData(1);
    yCenter = obstacleData(2);
    zCenter = obstacleData(3);
    width = obstacleData(4);
    length = obstacleData(5);
    height = obstacleData(6);
    for i=1:numberOfObstaclesToCheck
        xCenterCheck = obstacleDataList(i,1);
        yCenterCheck = obstacleDataList(i,2);
        zCenterCheck = obstacleDataList(i,3);
        widthCheck = obstacleDataList(i,4);
        lengthCheck = obstacleDataList(i,5);
        heightCheck = obstacleDataList(i,6);
        xDistance = abs(xCenter - xCenterCheck);
        yDistance = abs(yCenter - yCenterCheck);
        zDistance = abs(zCenter - zCenterCheck);
        combinedWidth = width + widthCheck;
        combinedLength = length + lengthCheck;
        cobminedHeight = height + heightCheck;
        if xDistance < combinedWidth/2 & yDistance < combinedLength/2 & zDistance < cobminedHeight/2
            doesOverlap = true;
        end
    end
end

