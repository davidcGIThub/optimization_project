function isInside = checkIfPointIsInsideTriangle(xyzPointsOfTriangle, intersectionPointOnPlane)
    %find the intersection point as function of weighted average of 3
    %points of triangle, if any are negative, its outside the triangle
    % w1x1 + w2x2 + w3x3 = Ix
    % w1y1 + w2y2 + w3y3 = Iy
    % w1z1 + w2z2 + w3z3 = Iz
    isInside = true;
    x1 = xyzPointsOfTriangle(1,1);
    x2 = xyzPointsOfTriangle(2,1);
    x3 = xyzPointsOfTriangle(3,1);
    y1 = xyzPointsOfTriangle(1,2);
    y2 = xyzPointsOfTriangle(2,2);
    y3 = xyzPointsOfTriangle(3,2);
    z1 = xyzPointsOfTriangle(1,3);
    z2 = xyzPointsOfTriangle(2,3);
    z3 = xyzPointsOfTriangle(3,3);
    Ix = intersectionPointOnPlane(1);
    Iy = intersectionPointOnPlane(2);
    Iz = intersectionPointOnPlane(3);
    syms w1  w2  w3
    eqn1 = w1*x1 + w2*x2 + w3*x3 == Ix;
    eqn2 = w1*y1 + w2*y2 + w3*y3 == Iy;
    eqn3 = w1*z1 + w2*z2 + w3*z3 == Iz;
    sol = solve([eqn1, eqn2, eqn3], [w1, w2, w3]);
    if ~isempty(sol.w1) || ~isempty(sol.w2) || ~isempty(sol.w3)
        if sol.w1 < 0 || sol.w2 < 0 || sol.w3 < 0
            isInside = false;
        end
    end
%     w3Term1 = (Ix*y1/x1 - Iy) * (x2*z1/x1 - z2) / (x2*y1/x1 -y2) - (Ix*z1/x1 -Iz);
%     w3Term2 = (x3*y1/x1 - y3) * (x2*z1/x1 - z2) / (x2*y1/x1 - y2) - (x3*z1/x1 - z3);
%     w3 = w3Term1/w3Term2;
%     if w3 < 0
%         isInside = false;
%         return;
%     end
%     w2Term1 = Ix*y1/x1 - Iy - w3*(x3*y1/x1 - y3);
%     w2Term2 = x2*y1/x1 - y2;
%     w2 = w2Term1/w2Term2;
%     if w2 < 0 
%         isInside = false;
%         return;
%     end
%     w1 = (Iy - w3*y3 -w2*y2) / y1;
%     if w1 < 0 
%         isInside = false;
%         return;
%     end
end

