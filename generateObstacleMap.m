function [obstacleList , obstacleDataList] = generateObstacleMap()
%     obstacle = makeRectangularPrism(length,width,height,[xCenter,yCenter,zCenter])
%     obstacleData = [xCenter,yCenter,zCenter,width,length,height];

     numberOfObstacles = 12;
     obstacleList = zeros(3,3,12,numberOfObstacles);
     obstacleDataList = zeros(numberOfObstacles , 6);
     
     obstacle1 = makeRectangularPrism(2,2,4,[1,1,2]);
     obstacleData1 = [1,1,2,2,2,4];
     obstacleList(:,:,:,1) = obstacle1;
     obstacleDataList(1,:) = obstacleData1;
     
     obstacle2 = makeRectangularPrism(1,1,2,[3.5,0.5,1]);
     obstacleData2 = [3.5,0.5,1,1,1,2];
     obstacleList(:,:,:,2) = obstacle2;
     obstacleDataList(2,:) = obstacleData2;
     
     obstacle3 = makeRectangularPrism(2,2,2,[6,1,1]);
     obstacleData3 = [6,1,1,2,2,2];
     obstacleList(:,:,:,3) = obstacle3;
     obstacleDataList(3,:) = obstacleData3;
         
     obstacle4 = makeRectangularPrism(1,1,3,[8.5,0.5,1.5]);
     obstacleData4 = [8.5,0.5,1.5,1,1,3];
     obstacleList(:,:,:,4) = obstacle4;
     obstacleDataList(4,:) = obstacleData4;
     
     obstacle6 = makeRectangularPrism(1,1,2.5,[3.5,2.5,1.25]);
     obstacleData6 = [3.5,2.5,1.25,1,1,2.5];
     obstacleList(:,:,:,5) = obstacle6;
     obstacleDataList(5,:) = obstacleData6;
         
     obstacle7 = makeRectangularPrism(1,7,1,[3.5,3.5,0.5]);
     obstacleData7 = [3.5,3.5,0.5,7,1,1];
     obstacleList(:,:,:,6) = obstacle7;
     obstacleDataList(6,:) = obstacleData7;
         
     obstacle8 = makeRectangularPrism(2,2,2,[9,3,1]);
     obstacleData8 = [9,3,1,2,2,2];
     obstacleList(:,:,:,7) = obstacle8;
     obstacleDataList(7,:) = obstacleData8;
         
     obstacle9 = makeRectangularPrism(2,3,3,[1.5,6,1.5]);
     obstacleData9 = [1.5,6,1.5,3,2,3];
     obstacleList(:,:,:,8) = obstacle9;
     obstacleDataList(8,:) = obstacleData9;
         
     obstacle10 = makeRectangularPrism(2,5,1,[6.5,6,0.5]);
     obstacleData10 = [6.5,6,0.5,5,2,1];
     obstacleList(:,:,:,9) = obstacle10;
     obstacleDataList(9,:) = obstacleData10;
         
     obstacle12 = makeRectangularPrism(1,1,3,[1.5,8.5,1.5]);
     obstacleData12 = [1.5,8.5,1.5,1,1,3];
     obstacleList(:,:,:,10) = obstacle12;
     obstacleDataList(10,:) = obstacleData12;
         
     obstacle13 = makeRectangularPrism(2,2,2,[4,9,1]);
     obstacleData13 = [4,9,1,2,2,2];
     obstacleList(:,:,:,11) = obstacle13;
     obstacleDataList(11,:) = obstacleData13;
         
     obstacle15 = makeRectangularPrism(1,4,1.5,[8,8.5,.75]);
     obstacleData15 = [8,8.5,.75,4,1,1.5];
     obstacleList(:,:,:,12) = obstacle15;
     obstacleDataList(12,:) = obstacleData15;
end

