function [a,b,c,x0,y0,z0] = getLineFromTwoPoints(xyzPoints)
    % x = x0 + ta
    % y = y0 + tb
    % z = z0 + tc
    %assume t = 1 at (x1,y1,z1)
    x0 = xyzPoints(1,1);
    x1 = xyzPoints(2,1);
    y0 = xyzPoints(1,2);
    y1 = xyzPoints(2,2);
    z0 = xyzPoints(1,3);
    z1 = xyzPoints(2,3);
    a = x1-x0;
    b = y1-y0;
    c = z1-z0;
end