function plotObstacles(obstacles)
    if size(size(obstacles)) < 4
        numberOfObstacles = 1;
    else
        numberOfObstacles = size(obstacles,4);
    end
    for i = 1:numberOfObstacles
        obstacle = obstacles(:,:,:,i);
        plotObstacle(obstacle);
        hold on;
    end
end

