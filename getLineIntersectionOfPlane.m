function [t, x, y , z] = getLineIntersectionOfPlane(lineEquation,planeEquation)
    % Ax + By + Cz + D = 0
    % x = x0 + ta
    % y = y0 + tb
    % z = z0 + tc
    % solve for x,y,z,t
    
    a = lineEquation(1);
    b = lineEquation(2);
    c = lineEquation(3);
    x0 = lineEquation(4);
    y0 = lineEquation(5);
    z0 = lineEquation(6);
    A = planeEquation(1);
    B = planeEquation(2);
    C = planeEquation(3);
    D = planeEquation(4);
    t = (-x0*A - y0*B - z0*C - D) / (a*A + b*B + c*C);
    x = x0 + t*a;
    y = y0 + t*b;
    z = z0 + t*c;
end