function  plotObstacle(obstacle)
    Xfill = reshape( obstacle(:,1,:) , [3,12]);
    Yfill = reshape( obstacle(:,2,:) , [3,12]);
    Zfill = reshape( obstacle(:,3,:) , [3,12]);
%     fill3(Xfill, Yfill, Zfill,'b','FaceAlpha',.1)
    fill3(Xfill, Yfill, Zfill,'b');
end