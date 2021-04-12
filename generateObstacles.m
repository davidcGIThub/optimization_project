function [obstacleList , obstacleDataList] = generateObstacles(numberOfObstacles, xlimits, ylimits, zlimits)
    %assume limit(2) is greater than limit(1)
    graphWidth = xlimits(2) - xlimits(1);
    graphLength = ylimits(2) - ylimits(1);
    graphHeight = zlimits(2) - zlimits(1);
    maxObstacleWidth = (graphWidth)/2;
    maxObstacleLength = (graphLength)/2;
    maxObstacleHeight = (graphHeight)/2;
    xGraphCenter = (xlimits(1) + xlimits(2))/2;
    yGraphCenter = (ylimits(1) + ylimits(2))/2;
    zGraphCenter = (zlimits(1) + zlimits(2))/2;
    obstacleList = zeros(3,3,12,numberOfObstacles);
    obstacleDataList = zeros(numberOfObstacles , 6);
    i=1;
    while i <= numberOfObstacles
        width = rand*maxObstacleWidth;
        length = rand*maxObstacleLength;
        height = rand*maxObstacleHeight;
        if i == 1
            xCenter = xGraphCenter;
            yCenter = yGraphCenter;
            zCenter = zGraphCenter;
        else
            xCenter = xGraphCenter + (graphWidth-width)*(rand-0.5);
            yCenter = yGraphCenter + (graphLength-length)*(rand-0.5);
            zCenter = zGraphCenter + (graphHeight-height)*(rand-0.5);
        end
        obstacleData = [xCenter,yCenter,zCenter,width,length,height];
        if i == 1 || ~checkIfObstaclesOverlap(obstacleData,obstacleDataList(1:i-1,:))
            obstacle = makeRectangularPrism(length,width,height,[xCenter,yCenter,zCenter]);
            obstacleList(:,:,:,i) = obstacle;
            obstacleDataList(i,:) = obstacleData;
            i = i+1;
        end
    end
end
